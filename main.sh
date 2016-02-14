#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

. "$DIR/defaults.sh"
. "$DIR/remote_session_aliases.sh"
. "$DIR/shortcut_aliases.sh"

eval $default_session
