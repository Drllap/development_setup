# Obsidian Dropbox Sync

This documents the local rclone setup that syncs the Obsidian vault with Dropbox.

## Paths

- Local vault: `/home/palli/Obsidian`
- Dropbox vault: `dropbox:Obsidian`
- rclone remote: `dropbox:`
- rclone config: `/home/palli/.config/rclone/rclone.conf`
- Sync state and logs: `/home/palli/.local/state/rclone-obsidian-dropbox`

Keep `/home/palli/.config/rclone/rclone.conf` private. It contains the Dropbox OAuth token.

## Files In This Repo

### `scripts/obsidian-dropbox-bisync.sh`

Runs `rclone bisync` between the local Obsidian vault and Dropbox.

What it does:

- Verifies that `/home/palli/Obsidian/.obsidian` exists before syncing.
- Uses `flock` so two sync jobs cannot run at the same time.
- Stores bisync state under `~/.local/state/rclone-obsidian-dropbox/bisync`.
- Writes logs to `~/.local/state/rclone-obsidian-dropbox/sync.log`.
- Uses `--modify-window 1s` because Dropbox stores file modification times at second precision.
- Keeps backups of changed or deleted local files under `~/.local/state/rclone-obsidian-dropbox/backups/local`.
- Keeps backups of changed or deleted Dropbox files under `dropbox:.rclone-backup/Obsidian`.
- Limits deletes with `--max-delete 20`.
- Excludes `.git`, `.codex`, `.agents`, `.obsidian/workspace.json`, `.obsidian/workspace-mobile.json`, `.DS_Store`, and `Thumbs.db`.

The workspace files are excluded because they are Obsidian UI/session state: open panes, active files, sidebar state, and similar per-machine details. Syncing them creates noisy changes and avoidable conflicts.

Useful environment overrides:

```bash
OBSIDIAN_LOCAL=/path/to/vault
OBSIDIAN_REMOTE=dropbox:some/path
OBSIDIAN_RCLONE_MAX_DELETE=20
RCLONE_LOG_LEVEL=INFO
OBSIDIAN_RCLONE_STATE_DIR=/path/to/state
```

### `systemd/user/rclone-obsidian-dropbox.service`

Runs the sync script once.

It is a `Type=oneshot` user service, so it starts, performs one sync pass, and exits. It only runs if `/home/palli/Obsidian/.obsidian` exists.

### `systemd/user/rclone-obsidian-dropbox.timer`

Runs the service automatically.

Schedule:

- Runs 2 minutes after boot.
- Runs every 10 minutes by clock schedule.
- Uses `Persistent=true`, so missed timer runs are handled after the user systemd session starts again.

## Useful Commands

Check timer status:

```bash
systemctl --user status rclone-obsidian-dropbox.timer --no-pager
```

See when it runs next:

```bash
systemctl --user list-timers rclone-obsidian-dropbox.timer --no-pager
```

Run a sync manually:

```bash
systemctl --user start rclone-obsidian-dropbox.service
```

Check the last service run:

```bash
systemctl --user status rclone-obsidian-dropbox.service --no-pager
```

Watch the rclone sync log:

```bash
tail -n 100 ~/.local/state/rclone-obsidian-dropbox/sync.log
```

Follow the log live:

```bash
tail -f ~/.local/state/rclone-obsidian-dropbox/sync.log
```

List Dropbox vault files:

```bash
rclone lsf dropbox:Obsidian --max-depth 2
```

Check Dropbox vault size:

```bash
rclone size dropbox:Obsidian
```

Run a dry-run bisync check:

```bash
/home/palli/dev/development_setup/scripts/obsidian-dropbox-bisync.sh --dry-run
```

Disable automatic sync:

```bash
systemctl --user disable --now rclone-obsidian-dropbox.timer
```

Enable automatic sync:

```bash
systemctl --user enable --now rclone-obsidian-dropbox.timer
```

Reload systemd after editing unit files:

```bash
systemctl --user daemon-reload
```

Reinstall the repo unit files into the live user systemd directory:

```bash
install -Dm644 systemd/user/rclone-obsidian-dropbox.service ~/.config/systemd/user/rclone-obsidian-dropbox.service
install -Dm644 systemd/user/rclone-obsidian-dropbox.timer ~/.config/systemd/user/rclone-obsidian-dropbox.timer
systemctl --user daemon-reload
```

## First-Time Or Recovery Commands

The first sync was initialized from the local vault to the empty Dropbox target with:

```bash
/home/palli/dev/development_setup/scripts/obsidian-dropbox-bisync.sh --resync
```

Use `--resync` only for initialization or recovery. Normal scheduled runs should not use it.

Before any recovery run, check what would happen:

```bash
/home/palli/dev/development_setup/scripts/obsidian-dropbox-bisync.sh --resync --dry-run
```

## Notes

This is bidirectional sync, not real-time collaborative editing. Avoid editing the same note on two machines at the same time. If two sides change the same file before a sync pass, rclone may create conflict files or require manual recovery.

The Dropbox folder `dropbox:Obsidian` is the combined vault root. The old `dropbox:Obsidian/Obsidian-Vault` target is no longer used.
