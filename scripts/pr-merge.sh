#!/usr/bin/env zsh

RED_COLOR="#f14e32"
DEBUG=

#################### Options ####################
number=
declare -a mergeOpt=("--merge")
declare -a stateOpt=("open") # generally only used for debugging.
verboseOpt=

zparseopts -D -F -K -- \
  {c,-choose}=mergeOpt \
  {m,-merge}=mergeOpt \
  {r,-rebase}=mergeOpt \
  {s,-squash}=mergeOpt \
  -state+:=stateOpt \
  {v,-verbose}=verboseOpt

DEBUG=$verboseOpt
merge_type=${mergeOpt[-1]}
number=$1
state=${stateOpt[-1]}

#################### Helpers ####################

function debug_print() {
  if [[ -n $DEBUG ]]; then
    echo "DEBUG: $@"
  fi
}

# Apply color style to text.
function color_text () {
  gum style --foreground "$RED_COLOR" "$1"
}

# Select a pull-request from a list.
function select_pr() {

   # Get the list of pull-requests matching the state.
   local prs="$(gh pr list \
    --state $state \
    --json number,title \
    --template '{{range .}}{{printf "%v" .number}} {{.title}}{{"\n"}}{{end}}')"

  # Breaks the pull requests into just their merge number, to see if a single merge is open.
  local nums=(${=$(echo "$prs" | grep -o -E '[0-9]+')})

  debug_print "nums: $nums"
  debug_print "prs-count: ${#nums}"

  if [[ ${#nums} -eq 1 ]]; then
    number="${nums}"
  elif [[ -n "$prs" ]]; then
    local choice=$(echo "$prs" | tr '' '\n' | gum choose)
    number=$(cut -d ' ' -f1 <<< "$choice")
  else
    echo "No $(color_text $state) pull-requests."
  fi
}

function select_merge_type() {
  echo "Choose the $(color_text merge) strategy."
  local merge_choice="$(gum choose merge rebase squash)"
  merge_type="--${merge_choice}"
}

function merge_pr() {

  if [[ -z $merge_type ]]; then
    echo "$(color_text "Merge") not found."
  fi

  if [[ -z $number ]]; then
    echo "$(color_text "Number") not found."
    exit 0
  fi

  debug_print "Merging number: $number"
  debug_print "Merge strategy: $merge_type"

  gh pr merge $merge_type $number
}

#################### Main ####################

debug_print "Begin"
debug_print "number: $number"
debug_print "merge-type: $merge_type"
debug_print "state: $state"
debug_print "merge-opt: $mergeOpt"

if [[ -z $number ]]; then
  select_pr
fi

debug_print "number: $number"

if [[ "$merge_type" == "-c" ]] || [[ "$merge_type" == "--choose" ]]; then
  select_merge_type
fi

merge_pr "$number"
debug_print "Done"
