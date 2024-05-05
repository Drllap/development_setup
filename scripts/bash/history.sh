#!/bin/bash

export HISTCONTROL=erasedups:ignoredups:ignorespace
# export HISTSIZE=5000      # Number of commands in command history
export HISTFILESIZE=5000    # Number of commands written to the history file

function update_history {
  history -n; # Read missing from history file to list
  history -w; # Write current history list to file
  history -c; # Clear the history list
  history -r; # Read history file to history list
}

if [[ -v precmd_functions ]]; then
  precmd_functions+=(update_history)
fi

