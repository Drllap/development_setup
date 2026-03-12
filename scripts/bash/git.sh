#!/bin/bash

function wtf {

  repos=( \
  )

  function run_fzf {
    local prefix_to_remove="^/home/palli/dev/"
    local preview_window='right:45%:wrap'

    if [[ ${COLUMNS:-0} -lt 180 ]]; then
      preview_window='right:35%:wrap'
    fi

    if [[ ${COLUMNS:-0} -lt 140 ]]; then
      preview_window='down:40%:wrap'
    fi

    for repo in "${repos[@]}"; do
      git -C "$repo" worktree list --porcelain 2>/dev/null \
        | awk -v prefix_to_remove="$prefix_to_remove" '
            /^worktree / {
              if (path != "") {
                display = path
                sub(prefix_to_remove, "", display)
                print path "\t" display "\t" branch
              }
              path = substr($0, 10)
              branch = ""
              next
            }

            /^branch / {
              branch = $2
              sub(/^refs\/heads\//, "", branch)
              next
            }

            END {
              if (path != "") {
                display = path
                sub(prefix_to_remove, "", display)
                print path "\t" display "\t" branch
              }
            }
          '
    done \
    | awk -F '\t' '
        {
          rows[NR] = $0
          if (length($2) > max_display_width) {
            max_display_width = length($2)
          }
        }

        END {
          for (i = 1; i <= NR; ++i) {
            split(rows[i], fields, "\t")
            printf "%s\t%-*s\t%s\n", fields[1], max_display_width, fields[2], fields[3]
          }
        }
      ' \
    | fzf --cycle \
        --delimiter=$'\t' \
        --with-nth=2,3 \
        --preview 'wt={1}; 
                   if [ -d "$wt/.git" ] || [ -f "$wt/.git" ]; then
                     git -C "$wt" -c color.status=always status --short --branch 2>/dev/null \
                       | (command -v bat >/dev/null && bat --paging=never --plain --language=diff || cat)
                   else
                     echo "Not a git worktree: $wt"
                   fi' \
        --preview-window "$preview_window" \
        --bind 'enter:become(echo {1})'
  }

  dest=$(run_fzf)
  if [[ -n $dest ]]; then
    builtin cd "$dest";
  else
    echo "empty"
  fi
}

