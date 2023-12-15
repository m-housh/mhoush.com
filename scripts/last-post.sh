#!/bin/zsh

echo "$(find content/posts/* -type d -ctime -1 | sort -nr | head -1)"
