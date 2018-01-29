#!/bin/bash

function create_session_alias ()
{
	name=$1; is_remote=${2:-true}; user=${3:-$default_user}; host=${4:-$default_host};
	ssh_client=${5:-$default_ssh_client}

	tmux_session="tmux attach -t $name || tmux new -s $name"
	if $is_remote ; then
		alias $name="mosh $user@$host -- $tmux_session"
	else
		alias $name="$tmux_session"
	fi
}

# TODO: Add session parameters to the session names list.
session_names=(work blog tinker)
default_session="${session_names[0]}"
for name in "${session_names[@]}"
do
	create_session_alias $name
done

create_session_alias "lcl" false
