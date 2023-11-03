#!/bin/bash

tmp_dir="/tmp"
timer_files=( $(ls "$tmp_dir/" | grep "timer_*") )
# echo ${timer_files[@]}
i=0
for timer_file in ${timer_files[@]}; do
	timer_nr="$(echo $timer_file | grep -o "\d")"
	timer_value="$(tail -n1 ${tmp_dir}/${timer_file})"
	timer_display="$timer_value"
	if [[ ${#timer_files[@]} > 1 ]]; then
		timer_display="($timer_nr)$timer_value"
	fi
	if [[ $i > 0 ]]; then
		output+=" | $timer_display"
	else
		output+="$timer_display"
	fi
	i=$((i+1))
done

if [[ -n $output ]]; then
	output="[$output]"
fi

echo "$output"
