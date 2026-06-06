#!/usr/bin/env bash
set -euo pipefail

LOCAL=${OBSIDIAN_LOCAL:-/home/palli/Obsidian}
REMOTE=${OBSIDIAN_REMOTE:-dropbox:Obsidian}
MAX_DELETE=${OBSIDIAN_RCLONE_MAX_DELETE:-20}
LOG_LEVEL=${RCLONE_LOG_LEVEL:-INFO}

STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state"}
STATE_DIR=${OBSIDIAN_RCLONE_STATE_DIR:-"$STATE_HOME/rclone-obsidian-dropbox"}
WORKDIR="$STATE_DIR/bisync"
LOCK_FILE="$STATE_DIR/sync.lock"
LOG_FILE="$STATE_DIR/sync.log"
LOCAL_BACKUP_DIR="$STATE_DIR/backups/local"
REMOTE_BACKUP_ROOT="dropbox:.rclone-backup/Obsidian"

if [[ ! -d "$LOCAL/.obsidian" ]]; then
    echo "Not an Obsidian vault: $LOCAL" >&2
    exit 1
fi

mkdir -p "$WORKDIR" "$LOCAL_BACKUP_DIR"

exec 9>"$LOCK_FILE"
if ! flock -n 9; then
    echo "Obsidian Dropbox sync is already running; exiting."
    exit 0
fi

stamp=$(date +%Y%m%d-%H%M%S)

exec rclone bisync "$LOCAL" "$REMOTE" \
    --workdir "$WORKDIR" \
    --create-empty-src-dirs \
    --resilient \
    --recover \
    --modify-window 1s \
    --exclude "/.git/**" \
    --exclude "/.codex/**" \
    --exclude "/.agents/**" \
    --exclude "/.obsidian/workspace.json" \
    --exclude "/.obsidian/workspace-mobile.json" \
    --exclude ".DS_Store" \
    --exclude "Thumbs.db" \
    --max-delete "$MAX_DELETE" \
    --backup-dir1 "$LOCAL_BACKUP_DIR/$stamp" \
    --backup-dir2 "$REMOTE_BACKUP_ROOT/$stamp" \
    --log-file "$LOG_FILE" \
    --log-level "$LOG_LEVEL" \
    "$@"
