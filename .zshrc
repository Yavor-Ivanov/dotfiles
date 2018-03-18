# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '/home/Y//.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install

export DASHT_DOCSETS_DIR=/cygdrive/i/docs/
# $(cygpath -ua "$VS140COMNTOOLS/vsvars32.bat") > /dev/null

eval $(thefuck --alias)
PATH="/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin::${PATH}"
export PATH
source ~/.dotfiles/main.sh

alias xdg-open="cygstart"
