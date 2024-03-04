#!/bin/bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

DEV_DIR="$(realpath $(dirname $(readlink -f $BASH_SOURCE))/../)"

if [ -f $DEV_DIR/secrets/secret-handlers.sh ] ; then
    source $DEV_DIR/secrets/secret-handlers.sh
fi
if [ -f $DEV_DIR/scripts/bash/plex.sh ] ; then
    source $DEV_DIR/scripts/bash/plex.sh
fi
if [ -f $DEV_DIR/scripts/bash/conan.sh ] ; then
    source $DEV_DIR/scripts/bash/conan.sh
fi
source $DEV_DIR/scripts/bash/aliases.sh
source $DEV_DIR/scripts/bash/path.sh
source $DEV_DIR/scripts/bash/fzf.sh
source $DEV_DIR/scripts/bash/shell-options.sh

source /usr/share/doc/pkgfile/command-not-found.bash

export LSP_Servers=$(realpath $DEV_DIR/../../LSP-Servers)

# use 'bat' for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# use 'vivid' to color theme 'ls'/'tree'/'fd'/ ...
export LS_COLORS="$(vivid generate gruvbox-dark-hard)"

export EDITOR="nvim"
export VISUAL="nvim"

export DIFFPROG='nvim -d'

eval "$(zoxide init bash)"
eval "$(starship init bash)"

