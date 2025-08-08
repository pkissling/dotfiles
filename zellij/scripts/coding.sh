#!/bin/bash

# if argument are passed, use as current dir, otherwise prompt for folder selection
dir="$1"
# Convert to absolute path if argument is provided
[ -n "$dir" ] && dir=$(realpath "$dir")
[ -z "$dir" ] && dir=$(find ~/Coding -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf)
[ -z "$dir" ] && echo "No directory selected. Exiting." && exit 1
session_name="coding-$(basename "${dir}")"
zellij pipe -p sessionizer -n sessionizer-new --args "name=${session_name},layout=coding,cwd=${dir}"
