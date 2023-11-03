#!/bin/bash

duration="${1:-0.1}"

default_fg="$(tmux show-option -g status-fg)"
default_bg="$(tmux show-option -g status-bg)"

inverted_fg="$(tmux show-option -g status-fg | sed 's/fg/bg/')"
inverted_bg="$(tmux show-option -g status-bg | sed 's/bg/fg/')"

tmux set -g $inverted_fg
tmux set -g $inverted_bg

sleep "$duration"

tmux set -g $default_fg
tmux set -g $default_bg
