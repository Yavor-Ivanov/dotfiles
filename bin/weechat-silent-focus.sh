#!/usr/bin/bash

# USAGE:
# -----------------------------------------------------------------------------
# Save this somewhere and run these commands in weechat
#   /set trigger.trigger.beep.command "/exec -bg /path/to/this-script.sh"
#   /save
#
# This will force weechat to run this script instead of generating a BEL
# signal at the terminal.
#
# If you want weechat to its original behaviour, run this:
#   /set trigger.trigger.beep.command "/beep"

# Alternatively, you can stick get_active_window_info in /usr/local/bin
get_active_window_info="/usr/local/bin/win32-get-active-window.exe"

term_window_class="mintty"
chat_title="chat"

active_window_info="$($get_active_window_info -c)"
class=$(echo "$active_window_info" | awk '/: /{print $NF}')
title=$(tmux display-message -p '#W')

if [[ $class != *"$term_window_class"* ]]; then
    echo -en "\a" > /dev/tty
# Enable this if you want bell when you have the terminal focused, but
# on a different tab than the chat. Note that I haven't done the research
# for tmux splits, so if you want that, you're going to figure it out on your
# own.
#
elif [[ $title != *"$chat_title"* ]]; then
    echo -en "\a" > /dev/tty
fi
