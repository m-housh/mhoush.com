#!/bin/sh

export NAP_HOME=".snippets"

function main() {
  dir=${1:=Series}
  # List the files in the series tags directory.
  files=$(ls "$NAP_HOME/$dir" | cut -d '.' -f 1)
  # Select the snippet file to use.
  choice=$(echo "$files" | gum filter)
  # Echo the selected file contents.
  echo "$(nap $choice)"
  echo "$(nap $choice)" | pbcopy
}


#nap $(nap list | gum filter)
main "$1"

