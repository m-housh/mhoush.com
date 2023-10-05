#!/usr/bin/env zsh

RED_COLOR="#f14e32"
DEBUG=

#################### Options ####################
number=
mergeOpt=
rebaseOpt=
declare -a stateOpt=("open")
squashOpt=
verboseOpt=

zparseopts -D -E -- \
  {m,-merge}=mergeOpt \
  {r,-rebase}=rebaseOpt \
  {s,-squash}=squashOpt \
  -state+:=stateOpt \
  {v,-verbose}=verboseOpt

state="${stateOpt[-1]}"
number=$1
DEBUG=$verboseOpt

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

  # The pull-request type to fetch
  state="${1:=open}"

   # Get the list of pull-requests matching the state.
  prs="$(gh pr list \
    --state $state \
    --json number,title \
    --template '{{range .}}{{printf "%v" .number}} {{.title}}{{"\n"}}{{end}}')"

  # Check that there are pull-requests returned.
  if [[ ${#prs} -eq 1 ]]; then
    echo ${prs[-1]}
  elif [[ -n "$prs" ]]; then
    choice=$(echo "$prs" | tr '' '\n' | gum choose)
    echo $(cut -d ' ' -f1 <<< "$choice")
  else
    echo "No $(color_text $state) pull-requests."
    exit 0
  fi
}

function parse_merge_type() {

  # check of an option was passed in.
  if [[ -n $mergeOpt ]]; then
    echo "--merge"
    return 0
  elif [[ -n $rebaseOpt ]]; then
    echo "--rebase"
    return 0
  elif [[ -n $squashOpt ]]; then
    echo "--squash"
    return 0
  fi

  echo "Choose the $(color_text merge) strategy."
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
  merge_type=$(parse_merge_type)
  if [[ -z $merge_type ]]; then
    echo "Merge type not found."
    exit 1
  fi
  gh pr merge "$number" "$merge_type"
}

#################### Main ####################

debug_print "all-state: $stateOpt"
debug_print "state: $state"

if [[ -z "$number" ]]; then
  number=$(select_pr $state)
fi

debug_print "number: $number"

if [[ -z "$number" ]]; then
  exit 1
fi

merge_pr "$number"

#parse_merge_type
