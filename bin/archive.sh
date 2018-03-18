#!/usr/bin/env bash

me="$(basename $0)"
if [ $1 == '' ]; then
	echo "USAGE: $me url"
fi
url=$1

wget -mpck --user-agent="" -e robots=off --wait 1 $url
