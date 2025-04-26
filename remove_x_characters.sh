#!/bin/bash

# Number of characters to remove
X="$1"

# Directory to search in
path="$2"

# Check if the number of characters is provided
if [[ -z "$X" || -z "$path" ]]; then
  echo "Usage: $0 <number_of_characters> <path>"
  exit 1
fi

# loop through all files in the current directory
for file in "$path"/*; do
    # checks if the file is a regular file
    if [[ -f "$file" ]]; then
        base="${file%.*}"
        ext="${file##*.}"
        new_len=$(( ${#base} - X ))
        if (( new_len < 0 )); then
            echo "Skipping $file — base name too short"
            continue
        fi
        new_base="${base:0:new_len}" # removes the last X characters
        if [[ "$ext" != "$file" ]]; then
            mv "$file" "$new_base.$ext"
            echo "Renamed $file to $new_base.$ext"
        else
            mv "$file" "$new_base"
            echo "Renamed $file to $new_base"
        fi
    fi
done