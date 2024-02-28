#!/bin/bash

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private cargo bin if it exists
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="~/.cargo/bin:$PATH"
fi

# Add win32yank to PATH when using WSL to be able copy-paste between Windows and the WSL
if [ -n "$WSL_DISTRO_NAME" ]; then
    PATH="/mnt/c/ProgramData/chocolatey/bin:$PATH"
fi

