#!/bin/bash

# SOURCE="${BASH_SOURCE[0]}"
# # Resolve $SOURCE until the file is no longer a symlink
# while [ -h "$SOURCE" ];
# do
# 	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
# 	SOURCE="$(readlink "$SOURCE")"

# 	# if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
# 	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
# done
# DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
#!/bin/bash

if [ -n "$ZSH_VERSION" ]; then
	setopt shwordsplit

    # Quiet, please
    alias pushd='pushd > /dev/null'
    alias popd='pushd > /dev/null'

    DIR=$(dirname ${(%):-%N})
elif [ -n "$BASH_VERSION" ]; then
    # Quiet, please
    pushd () {
        pushd "$@" > /dev/null
    }

    popd () {
        popd "$@" > /dev/null
    }
    DIR=$(dirname $BASH_SOURCE[0])
    shopt -s expand_aliases
fi

pushd $DIR
DIR=$(pwd)

function recursive()
{
    local cmd=$1
    local incl_path=$2
    local absolute=$3
    shift

    if [ -n "$ZSH_VERSION" ]; then
        if [[ -z $absolute ]]; then
            incl_path="$DIR/$incl_path"
        fi

        while read f; do
            $cmd "$f"
        done <<< "$(echo ${~incl_path} | tr " " "\n")"
    elif [ -n "$BASH_VERSION" ]; then
        shopt -s expand_aliases
        if [[ -z $absolute ]]; then
            incl_path="$DIR/$incl_path"
        fi

        while read f; do
            $cmd "$f"
        done <<< "$(echo ${incl_path} | tr " " "\n")"
    fi
    return 0
}

function include()
{
    source "$1" "$@"
}

function invoke()
{
    local file="$(realpath $1)"
    if [[ `readlink -e $file` ]]; then
        . $file
    else
        echo "Cannot invoke $file! No such file found."
    fi
}

recursive include "defaults.sh"
recursive include "aliases/*"
# invoke "./local/*"
popd
