#!/bin/zsh

title=$1

if [ -z "$title" ]; then
  echo "No title provided"
  exit 0
fi

hugo new content --kind post-bundle "posts/$title"
