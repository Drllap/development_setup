#!/bin/bash

function wtf {

  repos=( \
  )
  function run_fzf {
    printf "%s\n" "${repos[@]}" | xargs -I{} sh -c '
      repo="{}"
      git -C "$repo" worktree list
      ' | fzf --cycle --bind 'enter:become(echo {1})'
  }

  # echo "$(run_fzf)"
  dest=$(run_fzf)
  if [[ -n $dest ]]; then
    builtin cd $dest;
  else
    echo "empty"
  fi
}

