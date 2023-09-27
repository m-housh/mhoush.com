#!/usr/bin/env zsh

GIT_COLOR="#f14e32"

function git_color_text () {
  gum style --foreground "$GIT_COLOR" "$1"
}

function select_pr() {
  state="${1:=all}"
  prs="$(gh pr list \
    --state ${state} \
    --json number,title \
    --template '{{range .}}{{printf "%v" .number}} {{.title}}{{"\n"}}{{end}}')"

  if [[ -n "$prs" ]]; then
    choice=$(echo "$prs" | tr '' '\n' | gum choose)
    echo $(cut -d ' ' -f1 <<< "$choice")
  else
    echo "No $(git_color_text $state) pull-requests."
  fi
}

select_pr "$1"
