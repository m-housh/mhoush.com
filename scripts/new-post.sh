#!/bin/zsh

title=$1

if [ -z "$title" ]; then
  echo "No title provided"
  exit 0
fi

# Create the post.
post=$(hugo new content --kind post-bundle "posts/$(isosec)-$title")

# strip up to the first set of quotes.
post="${post#*\"}"
# strip backwards to the last set of quotes
post="${post%\"*}"

# Open the post
$EDITOR "$post/index.md"
