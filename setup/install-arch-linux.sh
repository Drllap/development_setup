#!/bin/sh
set -e

pacman -Su                  \
    sudo                    \
    man-db                  \
    man-pages               \
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
    alacritty               \
    zellij                  \
    curl                    \
    signal-desktop          \
    cmake                   \
    meson                   \
    tree                    \
    fd                      \
    ripgrep                 \
    bat                     \
    eza                     \
    clang                   \
    python                  \
    python-pipx             \
    pyright                 \
    zoxide                  \
    vlc                     \
    fzf                     \
    xclip                   \
    npm                     \
    lua-language-server     \
    luarocks                \
    stow                    \
    rustup                  \
    zig                     \
    zls                     \
    go                      \
    gopls                   \
    delve                   \
    gnupg                   \
    nushell                 \
    hyprland                \
    waybar                  \
    rofi-wayland            \
    wl-clipboard

npm install -g  \
    vim-language-server

pipx install  \
    cmake-language-server

# stow everything, execute from repo root
stow --target=$HOME bash
stow --target=$HOME git
stow --target=$HOME wezterm
stow --target=$HOME readline
stow --target=$HOME conan
stow --target=$HOME nushell
stow --target=$HOME starship
stow --target=$HOME awesome
stow --target=$HOME hyprland
stow --target=$HOME rofi
stow --target=$HOME waybar

