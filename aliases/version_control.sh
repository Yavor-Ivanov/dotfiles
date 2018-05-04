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

	# echo "$cmd called with $cmd_args"

	case $cmd in
		update)
			git pull
		;;
		switch)
			git checkout "$(get_first_match "${cmd_args[0]}")"
		;;
		switch-previous)
			git checkout @{-1}
		;;
		status)
			git status
		;;
		log)
			git log $cmd_args
		;;
		push)
			git push $cmd_args
		;;
		commit)
			git commit $cmd_args
		;;
		add)
			git add $cmd_args
		;;
		diff)
			git diff $cmd_args
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
		*)
			echo "ERROR: '$cmd' is not implemented!"
		;;
	esac
}
va() { version_control add "$@"; }
vc() { version_control commit "$@"; }
vw() { version_control switch "$@"; }
vwp() { version_control switch-previous "$@"; }
vu() { version_control update "$@"; }
vum() { version_control update-merge "$@"; }
vp() { version_control push "$@"; }
vs() { version_control status "$@"; }
vl() { version_control log "$@"; }
vd() { version_control diff "$@"; }
alias u='vu'
alias p='vp'
