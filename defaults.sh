#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR=$VISUAL

default_host=juicebox
default_client=mosh
default_user=ppm

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

case "$TERM" in
xterm*|rxvt*|*color)
	PS1="\u@\h:\w\\$ \[$(tput sgr0)\]"
    ;;
*)
    ;;
esac

case "$OSTYPE" in
	darwin*)
		# NOTE: Run `brew install coreutils` on OSX to use the
		# standard Linux utilities.
		PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
		MANPATH="/usr/local/opt/coreutils/libexec/gnuman:~/.dotfiles/bin/dasht/man:$MANPATH"
		export PYTHONPATH=/usr/local/Cellar/opencv/2.4.7.1/lib/python2.7/site-packages:$PYTHONPATH
	;;
esac

PATH="~/.dotfiles/bin/dasht/bin:$PATH"
MANPATH="~/.dotfiles/bin/dasht/man:$MANPATH"

set editing-mode vi
set -o vi
