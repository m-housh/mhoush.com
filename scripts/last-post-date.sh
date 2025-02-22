#!/bin/zsh

# Get's the last post's date portion of the filename.
#
# This is useful for prefixing images for a post correctly to keep them organized
# in the content/articles/images folder.

basename=$(just last-post-basename)
parts=(${(@s:-:)basename})
year=${parts[0,1]}
month=${parts[2,2]}
day=${parts[3,3]}
echo "${year}-${month}-${day}"
