#!/bin/bash

function wtf {

  repos=( \
  )
  function run_fzf {
    printf "%s\n" "${repos[@]}" | xargs -n1 -I{} sh -c '
      repo="{}"
      git -C "$repo" worktree list
      ' | fzf --cycle --bind 'enter:become(echo {1})'
  }

  # echo "$(run_fzf)"
  builtin cd "$(run_fzf)";
}

