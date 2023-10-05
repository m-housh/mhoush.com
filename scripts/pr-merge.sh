#!/usr/bin/env zsh

RED_COLOR="#f14e32"
DEBUG=

#################### Options ####################
number=
mergeOpt=
merge_type=
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
  local state="${1:=open}"

   # Get the list of pull-requests matching the state.
   local prs="$(gh pr list \
    --state $state \
    --json number,title \
    --template '{{range .}}{{printf "%v" .number}} {{.title}}{{"\n"}}{{end}}')"

  # Check that there are pull-requests returned.
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

function parse_merge_type() {

  # check of an option was passed in.
  if [[ -n $mergeOpt ]]; then
    merge_type="--merge"
  elif [[ -n $rebaseOpt ]]; then
    merge_type="--rebase"
  elif [[ -n $squashOpt ]]; then
    merge_type="--squash"
  fi

  if [[ -z $merge_type ]]; then
    echo "Choose the $(color_text merge) strategy."
    local merge_choice="$(gum choose merge rebase squash)"

    # return the appropriate merge strategy option.
    case $merge_choice in
      merge)
        merge_choice="--merge"
        ;;
      rebase)
        merge_choice="--rebase"
        ;;
      squash)
        merge_choice="--squash"
        ;;
    esac
  fi
}

function merge_pr() {
  #local number="${1}"
  parse_merge_type
  if [[ -z $merge_type ]]; then
    echo "$(color_text "Merge") type not found."
    exit 0
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

debug_print "all-state: $stateOpt"
debug_print "state: $state"

if [[ -z $number ]]; then
  select_pr $state
fi

debug_print "number: $number"

if [[ -z $number ]]; then
  debug_print "Exiting, no $(color_text "number") found."
  exit 0
fi

merge_pr "$number"
#parse_merge_type
