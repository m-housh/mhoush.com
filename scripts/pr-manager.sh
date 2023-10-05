#!/usr/bin/env zsh

GIT_COLOR="#f14e32"

# Apply color style to text.
function git_color_text () {
  gum style --foreground "$GIT_COLOR" "$1"
}

# Select a pull-request from a list.
function select_pr() {

  # The pull-request type to fetch
  state="${1:=open}"

   # Get the list of pull-requests matching the state.
  prs="$(gh pr list \
    --state $state \
    --json number,title \
    --template '{{range .}}{{printf "%v" .number}} {{.title}}{{"\n"}}{{end}}')"

  # Check that there are pull-requests returned.
  if [[ -n "$prs" ]]; then
    choice=$(echo "$prs" | tr '' '\n' | gum choose)
    echo $(cut -d ' ' -f1 <<< "$choice")
  else
    echo "No $(git_color_text $state) pull-requests."
    return 1
  fi
}

function choose_merge_type() {
  echo "Choose the $(git_color_text merge) strategy."
  merge_type="$(gum choose merge rebase squash)"

  # return the appropriate merge strategy option.
  case $merge_type in
    merge)
      echo "--merge"
      ;;
    rebase)
      echo "--rebase"
      ;;
    squash)
      echo "--squash"
      ;;
  esac
}

function merge_pr() {
  number=${1}
  merge_type=$(choose_merge_type)
  gh pr merge "$number" "$merge_type"
}

select_pr "$1"
#choose_merge_type
