#!/bin/bash

set -e

sudo apt update && apt install manpages-posix build-essential

pip3 install            \
  debugpy               \ `# Python DAP (Debug Adapter Protocol) server`   \
  conan                 \
  pyreadline              `# Needed for tab autocompletion in python shell`

# install homebew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install  \
  stow        \
  wget        \
  curl        \
  git         \
  gh          \
  unzip       \
  libtool     \
  autoconf    \
  cmake       \
  ninja       \
  llvm        \
  gdb         \
  rust        \
  python      \
  pipx        \
  pyright     \   # Python LSP (Language Server Protocoal) server
  luarocks    \
  neovim      \
  node        \
  yarn        \   # Used by iamcco/markdown-preview.nvim
  fzf         \
  ripgrep     \
  zoxide      \
  starship    \
  fd-find     \
  vivid       \
  eza         \
  bat         \
  harper      \
  cspell      \
  cmake-language-server \
  lua-language-server   \
  bash-language-server  \

sudo npm install -g                                               \
    vim-language-server                                           \
    @vlabo/cspell-lsp   # LSP wrapper for cspell

ln -sv $PWD/NeoVim/ ~/.config/nvim # depends on ~/.config/nvim not existing # We should use show here. But need to
# `NeoVim` folder for that. 

# TODO call stow

