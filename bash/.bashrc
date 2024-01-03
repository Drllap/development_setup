#!/bin/bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

alias ls='ls --color=auto'

DEV_DIR="$(realpath $(dirname $(readlink -f $BASH_SOURCE))/../)"

if [ -f $DEV_DIR/secrets/export-keys.sh ] ; then
    source $DEV_DIR/secrets/export-keys.sh
fi
if [ -f $DEV_DIR/scripts/bash/plex.sh ] ; then
    source $DEV_DIR/scripts/bash/plex.sh
fi
if [ -f $DEV_DIR/scripts/bash/conan.sh ] ; then
    source $DEV_DIR/scripts/bash/conan.sh
fi
source $DEV_DIR/scripts/bash/fzf.sh

export LSP_Servers=$(realpath $DEV_DIR/../../LSP-Servers)

export EDITOR="nvim"
export VISUAL="nvim"

eval "$(zoxide init bash)"

