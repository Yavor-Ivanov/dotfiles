#!/usr/bin/env bash

version_control() {
	script_args=( $@ )
	arg_len=${#args[@]}

	cmd=${script_args[0]}
	cmd_args=${script_args[@]:0:$arg_len}

	# echo "$cmd called with $cmd_args"

	case $cmd in
		update)
			git pull
		;;
		switch)
			git checkout $(git branch | g "$cmd_args[0]")
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
vw() { version_control switch $@; }
vu() { version_control update $@; }
vp() { version_control push $@; }
vs() { version_control status $@; }
vl() { version_control log $@; }
