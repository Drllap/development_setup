#!/bin/sh
set -e

pacman -Su                  \
    sudo                    \
    vim                     \
    neovim                  \
    neovide                 \
    git                     \
    github-cli              \
    bash-completion         \
    bash-language-server    \
    vivid                   \
    pkgfile                 \
    wezterm                 \
    curl                    \
    signal-desktop          \
    cmake                   \
    tree                    \
    fd                      \
    ripgrep                 \
    bat                     \
    clang                   \
    pyright                 \
    alacritty               \
    zellij                  \
    zoxide                  \
    vlc                     \
    fzf                     \
    xclip                   \
    npm                     \
    lua-language-server     \
    stow                    \
    rustup                  \
    zig                     \
    zls                     \
    nushell

npm install -g 
    vim-language-server

# stow everything, execute from repo root
stow --target=$HOME bash
stow --target=$HOME git
stow --target=$HOME wezterm
stow --target=$HOME readline
stow --target=$HOME conan
stow --target=$HOME nushell
stow --target=$HOME starship

