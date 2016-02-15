#!/bin/bash

session_names=(work blog tinker)
default_session="${session_names[0]}"

function create_session_alias ()
{
	name=$1; user=${2:-$default_user}; host=${3:-$default_host}; ssh_client=${4:-$default_ssh_client}
	alias $name="mosh $user@$host -- tmux attach -t $name || tmux new -s $name"
}

for name in "${session_names[@]}"
do
	create_session_alias $name
done
