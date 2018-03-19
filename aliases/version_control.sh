#!/usr/bin/env bash

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
			# @Todo <Yavor>: Fix this to list all matches and autocomplete somehow.
			first_match="$(git branch | grep "${cmd_args[0]}" | sed 's/\* \(.*\)/\1/' | sed 's/ *\(.*\)/\1/' | head -1)"
			git checkout $first_match
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
		*)
			echo "ERROR: '$cmd' is not implemented!"
		;;
	esac
}
va() { version_control add "$@"; }
vw() { version_control switch "$@"; }
vu() { version_control update "$@"; }
vp() { version_control push "$@"; }
vs() { version_control status "$@"; }
vl() { version_control log "$@"; }
alias u='vu'
alias p='vp'
