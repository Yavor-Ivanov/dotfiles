#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

ln -s "$DIR/.vimrc" ~/.vimrc
ln -s "$DIR/.vim" ~/.vim
ln -s "$DIR/.tmux.conf" ~/.tmux.conf
ln -s "$DIR/.w3m" ~/.w3m
sudo ln -s "$DIR/bin/" /usr/local/bin/
