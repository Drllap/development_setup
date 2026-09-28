#!/bin/bash

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ] ; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# # set PATH so it includes user's private cargo bin if it exists
# if [ -d "$HOME/.cargo/bin" ] ; then
#   PATH="$HOME/.cargo/bin:$PATH"
# fi

