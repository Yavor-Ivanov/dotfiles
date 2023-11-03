#!/bin/bash

me="$(basename $0)"

time_spec=$1
shift 1
task="$@"

stty -echoctl

print_usage() {
    >&2 echo ""
    >&2 echo "Usage: $me time_spec [task]"
    >&2 echo ""
    >&2 echo "Where time_spec can be an integer or string like 1h30m10s"
    >&2 echo ""
    >&2 echo "Examples:"
    >&2 echo ""
    >&2 echo "  - $me 30m - Run for 30 minutes"
    >&2 echo "  - $me 200 - Run for 200 seconds"
    >&2 echo "  - $me 50s - Run for 50 seconds"
    >&2 echo "  - $me 1m50s - Run for 1 minute and 50 seconds"
    >&2 echo "  - $me 3h10s - Run for 3 hours and 10 seconds"
}

if [ -z $time_spec ]; then
    print_usage
    exit
fi

if [ -n "$TMUX" ]; then
    tty_id="$(tmux display-message -p '#{pane_tty}')"
fi

cleanup() {
    echo ""
    if [ -n "$TMUX" ]; then
        window_number="$(tmux list-panes -aF "#{pane_tty}:#{window_index}" | grep "$tty_id" | cut -d':' -f2)"
        tmux set-option -t "$window_number" automatic-rename
    fi
}
trap cleanup EXIT

input_hours="$(echo "$time_spec" | grep -oE "[0-9]+h" | tr -d 'h')"
input_minutes="$(echo "$time_spec" | grep -oE "[0-9]+m" | tr -d 'm')"
input_seconds="$(echo "$time_spec" | grep -oE "[0-9]+s" | tr -d 's')"

calc_seconds=$((input_hours*3600 + input_minutes*60 + input_seconds))
if [[ $calc_seconds == 0 ]]; then
    re='^[0-9]+$'
    if ! [[ $time_spec =~ $re ]] ; then
        print_usage
        exit
    fi
    calc_seconds="$time_spec"
fi

while [ $calc_seconds -gt 0 ]; do
    norm_hours=$(( calc_seconds/3600 ))
    norm_minutes=$(( (calc_seconds-norm_hours*3600)/60 ))
    norm_seconds=$(( calc_seconds-norm_hours*3600-norm_minutes*60 ))

    display_str=""
    if [[ $norm_seconds -gt 0 ]]; then
        display_str="${norm_seconds}s"
    fi
    if [[ $norm_minutes -gt 0 ]]; then
        display_str="${norm_minutes}m${display_str}"
    fi
    if [[ $norm_hours -gt 0 ]]; then
        display_str="${norm_hours}m${display_str}"
    fi

    sleep 1 &
    clear_line=""

    # @Cleanup: We print twice because something is wrong with the cone that's supposed to
    # overwrite the last line.
    output="It's the final countdown: $display_str"
    space_count=$((${COLUMNS}-${#output}))
    printf "\r%s%${space_count}s" "$output" ""
    printf "\rIt's the final countdown: %s" $display_str

    if [ -n "$TMUX" ]; then
        window_number="$(tmux list-panes -aF "#{pane_tty}:#{window_index}" | grep "$tty_id" | cut -d':' -f2)"
        tmux rename-window -t "$window_number" "timer ($display_str)"
    fi

    calc_seconds=$(($calc_seconds - 1))
    wait
done

cleanup

eval "$task"
