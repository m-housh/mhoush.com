#!/bin/zsh
#
# Get's the last posts' base filename.
#
# This is useful for naming a banner image appropriately for a post
# in the content/articles/images folder.

# Get the last post's full file path.
local filepath=$(just last-post)

# remove leading folder paths.
local filename="${filepath##*/}"

# remove file extension and echo the result.
echo "${filename%.*}"
