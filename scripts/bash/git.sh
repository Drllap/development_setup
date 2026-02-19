#!/bin/bash

function wtf {

  repos=( \
  )

  function run_fzf {

    for repo in "${repos[@]}"; do
      git -C "$repo" worktree list --porcelain 2>/dev/null \
        | awk '/^worktree /{print $2}'
    done \
    | fzf --cycle \
        --preview 'wt={}; 
                   if [ -d "$wt/.git" ] || [ -f "$wt/.git" ]; then
                     git -C "$wt" -c color.status=always status --short --branch 2>/dev/null \
                       | (command -v bat >/dev/null && bat --paging=never --plain --language=diff || cat)
                   else
                     echo "Not a git worktree: $wt"
                   fi' \
        --preview-window 'right:60%:wrap' \
        --bind 'enter:become(echo {})'
  }

  dest=$(run_fzf)
  if [[ -n $dest ]]; then
    builtin cd $dest;
  else
    echo "empty"
  fi
}

