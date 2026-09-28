#!/bin/bash

alias nv='neovide'
alias n='nvim'
alias ls='eza'
alias vimdiff='nvim -d'
alias cd='z'
alias conan1='conan'
alias conan2='uvx conan@latest'

if [[ -n "$WSL_DISTRO_NAME" ]]; then
  alias win32yank="/mnt/c/Users/pallp/scoop/shims/win32yank.exe"
fi

