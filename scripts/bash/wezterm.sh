#!/bin/bash

# Report the CWD to the terminal with OSC 7 on every prompt.
#
# WezTerm spawns a new pane/tab (<alt+d>, <alt+D>, <alt+t>) in the CWD of the
# current pane, but it only knows that CWD if the shell tells it. Neither bash
# nor starship emit OSC 7, so without this a WSL pane falls back to the domain
# default_cwd -- the Windows CWD, i.e. /mnt/c/Users/<user>.

# Percent-encode $PWD and emit it as a file:// URL.
__wezterm_osc7() {
  local url="file://${HOSTNAME}"
  local i ch hex
  # Byte-wise, so that non-ASCII path components are encoded per byte (UTF-8).
  local LC_ALL=C
  for ((i = 0; i < ${#PWD}; i++)); do
    ch="${PWD:i:1}"
    case "$ch" in
      [a-zA-Z0-9/:._~-]) url+="$ch" ;;
      *) printf -v hex '%%%02X' "'$ch"; url+="$hex" ;;
    esac
  done
  printf '\e]7;%s\e\\' "$url"
}

if [ "$TERM_PROGRAM" = "WezTerm" ]; then
  # Appended, so starship_precmd still sees the real $? of the last command.
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__wezterm_osc7"
fi
