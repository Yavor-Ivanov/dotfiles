#!/bin/bash

alias clip='nc 127.0.0.1 8377 -q0'
alias e='$EDITOR'
alias g='grep -E'
alias f='ranger'

alias la='ls -la'
alias ll='ls -la'
alias ls='ls -a'

alias c='clear'
alias k='clear'
alias cls='clear'

alias up='cd ..'
alias back='cd -'
alias cd..='up'
alias md='mkdir -p'
alias rd='rmdir'
if [ ! -x "$(which tree 2>/dev/null)" ]
then
	alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias py='python'
alias py3='python3'
alias p3='py3'

eval $(thefuck --alias)
alias pls='fuck'
