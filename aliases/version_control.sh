#!/usr/bin/env bash

get_first_match() {
	# @Todo <Yavor>: Fix this to list all matches and autocomplete somehow.
	# @Todo <Yavor>: Make this accept strings with spaces and perform multiple greps.
	# @Bug <Yavor>: This doesn't pick the shortest match!
	first_match="$(git branch | grep "${cmd_args[0]}" | sed 's/\* \(.*\)/\1/' | sed 's/ *\(.*\)/\1/' | head -1)"
	echo "$first_match"
}

version_control() {
	script_args=( $@ )
	arg_len=${#script_args[@]}

	cmd=${script_args[0]}
	cmd_args=("${script_args[@]:1:$arg_len}")

	# echo "$cmd called with ${cmd_args[@]}"

	case $cmd in
		update)
			git pull
		;;
		switch)
			git checkout "$(get_first_match "${cmd_args[0]}")"
		;;
		switch-previous)
			ref=${cmd_args[0]:-1}
			git checkout @{-$ref}
		;;
		status)
			git status
		;;
		log)
			git log "${cmd_args[@]}"
		;;
		my_log)
			my_email="$(git config user.email)"
			git log --branches --author="$my_email" "${cmd_args[@]}"
		;;
		push)
			new_branch="$(git push "${cmd_args[@]}" --dry-run 2>&1 | g 'fatal')"
			if [ -n "$new_branch" ]; then
				branch_name="$(git rev-parse --abbrev-ref HEAD)"
				echo "git push --set-upstream origin "$branch_name" ${cmd_args[@]}"
				git push --set-upstream origin "$branch_name" "${cmd_args[@]}"
			else
				git push "${cmd_args[@]}"
			fi
		;;
		commit)
			git commit "${cmd_args[@]}"
		;;
		add)
			git add "${cmd_args[@]}"
		;;
		diff)
			# @Cleanup <Yavor>: This should really be configurable.
			git diff "${cmd_args[@]}"
		;;
		update-merge)
			has_uncommited_files="$(git status -s)"
			if [ -n "$has_uncommited_files" ]; then
				git stash
			fi
			branch_name="$(get_first_match ${cmd_args[0]})"
			git checkout "$branch_name"
			git pull
			git checkout @{-1}
			git merge "$branch_name"
			if [ -n "$has_uncommited_files" ]; then
				git stash pop
			fi
		;;
		checkout-history)
			# @Todo <Yavor>: Make it so we can checkout a branch using the history index
			branch_index="${cmd_args[@]}"
			max_git_history=30
			current_history_entry=1
			last_history_branch=""
			history_list_str=""
			history_list=()
			while [ $current_history_entry -le $max_git_history ]; do
				current_history_branch="$(git rev-parse --abbrev-ref @{-$current_history_entry} 2>/dev/null)"

				# @Note <Yavor>: Sometimes we have failed merges that are recorded in the reflog,
				# but we can't rev-parse the history entry for them into a name. For those, we
				# we need to look into the reflog itself.
				if [ "$current_history_branch" == "@{-$current_history_entry}" ]; then
					history_entry_sha="$(git reflog show HEAD@{$current_history_entry} | head -n 1 | cut -f1 -d' ')"
					current_history_branch="$(git describe --all --contains $history_entry_sha)"
				fi

				# @Note <Yavor>: This is the case where the commit doesn't point to a branch.
				# We'll assume it must point to a tag then, which may not be correct (for example,
				# if you've been recently bisecting).
				if [ -z "$current_history_branch" ]; then
					current_history_branch="$(git describe --tags @{-$current_history_entry} 2>/dev/null)"
				fi
				# @Note <Yavor>: If it's neither a branch name nor a tag name, we revert to
				# displaying the commit SHA
				if [ -z "$current_history_branch" ]; then
					current_history_branch="$(git rev-parse --short @{-$current_history_entry})"
				fi
				# if [ "$current_history_branch" != "$last_history_branch" ]; then
				# fi
				history_list+=("$current_history_branch")
				history_list_str="$history_list_str\n$current_history_entry\t$current_history_branch\n"
				current_history_entry=$((current_history_entry + 1));
			done

			# @Note <Yavor>: Either switch to the branch with that index or show a list of branches
			if [ "$branch_index" != "" ]; then
				git checkout "${history_list[$(($branch_index - 1))]}"
			else
				echo "$(echo -e "$history_list_str" | column -t -s "$(printf '\t')")"
			fi
		;;
		*)
			echo "ERROR: '$cmd' is not implemented!"
		;;
	esac
}
va()  { version_control add "$@"; }
vc()  { version_control commit "$@"; }
vw()  { version_control switch "$@"; }
vwp() { version_control switch-previous "$@"; }
vu()  { version_control update "$@"; }
vum() { version_control update-merge "$@"; }
vp()  { version_control push "$@"; }
vs()  { version_control status "$@"; }
vl()  { version_control log "$@"; }
vml() { version_control my_log "$@"; }
vd()  { version_control diff "$@"; }
vwh() { version_control checkout-history "$@"; }
alias u='vu'
alias p='vp'

if [ -f ~/.fzf.bash ];then
	complete -o bashdefault -o default -F _fzf_path_completion version_control
	complete -o bashdefault -o default -F _fzf_path_completion va
	complete -o bashdefault -o default -F _fzf_path_completion vd
fi

if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash

	__git_complete vw _git_checkout
	__git_complete vum _git_merge
	__git_complete u _git_merge
	__git_complete vd _git_diff
	__git_complete p _git_push
fi
