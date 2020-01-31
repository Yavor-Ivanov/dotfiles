#!/bin/bash

me="$(basename $0)"

time_sec=$1
shift 1
task="$@"
if [ -z $time_sec ]; then
	>&2 echo "Usage: $me time_in_seconds [task]"
	exit
fi

while [ $time_sec -gt 0 ]; do
	sleep 1 &
    printf "\rIt's the final countdown: %02d" $time_sec
    time_sec=$(($time_sec - 1))
    wait
done

echo ""

eval "$task"
