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

function up() {
	local count=${1:-1}
	local i=0;
	while [ $i -lt $count ]; do
		cd ..
		let i=i+1
	done
}
alias back='cd -'
alias cd..='up'
alias md='mkdir -p'
alias rd='rmdir'
if [ ! -x "$(which tree 2>/dev/null)" ]
then
	alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

alias info='info --vi-keys'
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
alias doc='dasht'
alias docs='doc'
alias br='breadability'
alias rr='br'

= () { echo "$@" | bc -l; }
json_pprint () { echo $1 | python -m json.tool; }

ecr_login() {
    local login_str="$(aws ecr get-login | sed 's/-e .* //')"
    eval "$login_str"
}

mana() {
	man -a $1 | $PAGER
}
