#!/bin/bash

#
# ~/.bash_profile
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi

