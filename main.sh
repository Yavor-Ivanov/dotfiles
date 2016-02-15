#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
shopt -s expand_aliases

function include()
{
	local incl_path=$1
	local absolute=$2
	shift
	shopt -s expand_aliases
	if [[ -z $absolute ]]
	then
		incl_path="$DIR/$incl_path"
	fi

	while read f
	do
		source "$f" "$@"
	done <<< "$(echo $incl_path | tr " " "\n")"
	return 0
}

include "defaults.sh"
include "aliases/*"

eval $default_session
