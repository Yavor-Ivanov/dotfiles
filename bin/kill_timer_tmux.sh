#!/bin/bash

timer_idx="$1"
tmp_dir="/tmp"

# @Todo:
#   1. Check if only one timer running, don't display prompt, just kill the timer
#   2. If more than one timer, display prompt to kill timer id, call timer -k $id

# If there's only one timer running, just kill it.
if [[ -z $timer_idx ]]; then
	timer_files=($(ls "$tmp_dir" | grep "timer_*"))
	if [[ "${#timer_files[@]}" == 1 ]]; then
		timer_idx="$(echo ${timer_files[0]} | grep -o '[0-9]\+')"
	else
		tmux command-prompt -p 'Kill timer #:' 'run-shell "kill_timer.sh %1 >/dev/null"'
		exit
	fi
fi

timer_file="$tmp_dir/timer_$timer_idx"
if ! [[ -f "$timer_file" ]]; then
	exit
fi

pid="$(head -n1 $timer_file)"
kill -SIGTERM "$pid"
