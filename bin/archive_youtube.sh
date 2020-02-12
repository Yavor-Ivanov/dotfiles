#!/usr/bin/env zsh

input_file="$1"

alias pushd='pushd > /dev/null'
alias popd='pushd > /dev/null'

pushed=false
zshexit() {
	if [[ "$pushed" == true ]]; then
		popd
	fi
	exit
}

# @Todo <Yavor>: Check if youtube-dl is installed and can be run.
# @Todo <Yavor>: Process different cwd.
if [[ ! -f "$input_file" ]]; then
	>&2 echo "ERROR: File $input_file doesn't exist!"
	exit
fi

file_contents="$(cat "$input_file")"
if [[ -z "$file_contents" ]]; then
	>&2 echo "ERROR: The file $input_file is empty!"
	exit
fi
# @Note <Yavor>: We go over the file contents twice: once to
# validate each line, then again to run the downloader.
line_num=1
had_parse_errors=false
while read -r line; do
	folder="$(echo "$line" | sed 's/\(.*\) .*/\1/')"
	youtube_channel_url="$(echo "$line" | sed 's/.* \(.*\)/\1/')"
	if [[ -z "$folder" ]] || [[ -z "$youtube_channel_url" ]]; then
		>&2 echo "ERROR: On line $line_num in $input_file. Folder or channel url missing!"
		had_parse_errors=true
	fi
	if [ ! -d "$folder" ]; then
		>&2 echo "ERROR: On line $line_num in $input_file. Folder $folder does not exist!"
		had_parse_errors=true
	fi
	line_num=$((line_num+1))
done <<< "$file_contents"

if [ "$had_parse_errors" = true ]; then
	exit
fi

# @Note <Yavor>: Actual download happens here
while read -r line; do
	folder="$(echo "$line" | sed 's/\(.*\) .*/\1/')"
	youtube_channel_url="$(echo "$line" | sed 's/.* \(.*\)/\1/')"

	pushd $folder
		pushed=true

		echo "###"
		echo "### In folder $folder; Will download $youtube_channel_url"
		echo "###"

		youtube-dl -i -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o "%(title)s - (%(release_date)s).%(ext)s" --download-archive archive.txt "$youtube_channel_url"
	popd
	pushed=false
done <<< "$file_contents"
