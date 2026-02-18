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
    uv                      \
    # python                  \
    # python-pipx             \
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

# pipx install  \
#     cmake-language-server

# The limitation of pygls is because of this bug:
# https://github.com/regen100/cmake-language-server/issues/101
uv tool install --with 'pygls<2' cmake-language-server
uv tool install 'conan<2'

# Crate a python venv for neovim to use
uv venv ~/.venvs/neovim
source ~/.venvs/neovim/bin/activate
uv pip install pynvim
deactivate

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
stow --target=$HOME rio
stow --target=$HOME gdb

