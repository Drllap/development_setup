local wezterm = require('wezterm')

local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

if wezterm.hostname() == 'archlinux' then
  -- use bash in not login mode
  -- doing it like this makes it so .bash_profile isn't sourced
  config.default_prog = { '/usr/bin/bash' }
  -- config.default_prog = { '/usr/bin/sh' }
else
  config.default_prog = { 'powershell', '-NoLogo' }
end

config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.

-- config.debug_key_events = true
config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true
-- config.warn_about_missing_glyphs = false

wezterm.on('update-right-status', function(window, pane)
  -- Show which key table is active in the status area
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
    window:set_right_status(name)
    return
  end

  -- Show latency
  local meta = pane:get_metadata()

  if not meta then
    return
  end

  if meta.is_tardy then
    local secs = meta.since_last_response_ms / 1000.0
    window:set_right_status(string.format('tardy: %5.1fs⏳', secs))
    return
  end

  window:set_right_status('')
end)

wezterm.on("toggle-tab", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.enable_tab_bar == nil then
    overrides.enable_tab_bar = false
  else
    overrides.enable_tab_bar = nil
  end
  window:set_config_overrides(overrides)
end)

config.ssh_domains = {
  {
    name = 'kvikna',
    remote_address = '192.168.20.161',
    username = 'KVIKNA\\palli',
  }
}

config.unix_domains = {
  {
    name = 'tmux',
  },
}

config.wsl_domains = {
  {
    name = "ub",
    distribution = "Ubuntu-20.04",
    -- This doesn't work for some reason -> default_cmd = "~/dev"
  },
}

config.leader = { key = 'Space', mods = 'ALT' }

config.keys = {
  { key = 't', mods = 'LEADER', action = act.EmitEvent("toggle-tab") },
  { key = 'T', mods = 'LEADER', action = act.ShowTabNavigator },

  -- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
  -- mode until we cancel that mode.
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, }, },

  -- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
  -- mode until we press some other key or until 1 second (1000ms)
  -- of time elapses
  { key = 'a', mods = 'LEADER', action = act.ActivateKeyTable { name = 'activate_pane', timeout_milliseconds = 1000, }, },

  -- Activate Copy Mode
  { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },

  -- Activate Quick Select Mode
  { key = 'q', mods = 'LEADER', action = act.QuickSelect },

  -- Overwrite old binding: CTRL-SHIFT-l activates the debug overlay
  { key = 'd', mods = 'LEADER', action = act.ShowDebugOverlay },
  -- Overwrite old binding: CTLR-SHIFT-p activates the Command Palette
  { key = 'p', mods = 'LEADER', action = act.ActivateCommandPalette, },

  -- Luncher Menu
  { key = 'l', mods = 'LEADER', action = act.ShowLauncher },
  -- { key = 'P', mods = 'SHIFT|ALT|CTRL', action = act.ShowLauncherArgs { flags = '' } },

  -- Window commands
  { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },

  -- Tab Commans
  { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = '1', mods = 'ALT|CTRL', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT|CTRL', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT|CTRL', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT|CTRL', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT|CTRL', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT|CTRL', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT|CTRL', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT|CTRL', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT|CTRL', action = act.ActivateTab(8) },

  -- Pane key maps

  -- Pane creation

  { key = 'd', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'D', mods = 'ALT', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },

  { key = 'C', mods = 'ALT', action = act.QuitApplication },
  { key = 'c', mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },

  -- Pane movements, "normal mode"
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left'},
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  -- Activate Pane Select mode
  { key = 'g', mods = 'ALT', action = act.PaneSelect },

  -- Scrolling
  -- Scrolling line
  { key = 'y', mods = 'ALT|CTRL', action = act.ScrollByLine(1)   },
  { key = 'e', mods = 'ALT|CTRL', action = act.ScrollByLine(-1)  },

  -- Scrolling multiple lines
  { key = 'd', mods = 'ALT|CTRL', action = act.ScrollByLine(15)  },
  { key = 'u', mods = 'ALT|CTRL', action = act.ScrollByLine(-15) },

  -- { key = 'p', mods = 'ALT|CTRL', action = act.ScrollToPrompt(1) },

  -- Copy paste
  { key = 'v', mods = 'ALT|CTRL', action = act.PasteFrom('Clipboard') },
}

config.key_tables = {
  -- Defines the keys that are active in our resize-pane mode.
  -- Since we're likely to want to make multiple adjustments,
  -- we made the activation one_shot=false. We therefore need
  -- to define a key assignment for getting out of this mode.
  -- 'resize_pane' here corresponds to the name="resize_pane" in
  -- the key assignments above.
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

  -- Defines the keys that are active in our activate-pane mode.
  -- 'activate_pane' here corresponds to the name="activate_pane" in
  -- the key assignments above.
  activate_pane = {
    -- { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },

    -- { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },

    -- { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },

    -- { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
  },
}

-- config.keys = {
--   -- Turn off the default CMD-m Hide action, allowing CMD-m to
--   -- be potentially recognized and handled by the tab
--   {
--     key = 'm',
--     mods = 'CMD',
--     action = wezterm.action.DisableDefaultAssignment,
--   },
-- }

return config
