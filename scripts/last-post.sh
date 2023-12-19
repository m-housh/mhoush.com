#!/bin/zsh

# Find the last modified directory in the content/posts directory.
echo "$(find content/posts/* -type d -ctime -30 | sort -nr | head -1)"
