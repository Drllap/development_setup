#!/bin/bash

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ] ; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

FZF_CTRL_T_COMMAND=fd
FZF_ALT_C_COMMAND=""    # because I want my own bindings

export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_CTRL_T_OPTS="--min-height 30 --preview-window right:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"

eval "$(fzf --bash)"

# Use CTRL+g instead of ALT+c for fzf-cd-ing to subfolder
bind -m emacs-standard '"\C-g": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\C-g": "\C-z\C-g\C-z"'
bind -m vi-insert '"\C-g": "\C-z\C-g\C-z"'


