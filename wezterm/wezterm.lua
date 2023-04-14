local wezterm = require('wezterm')

local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = { 'powershell', '-NoLogo' }

config.color_scheme = 'Gruvbox dark, medium (base16)'

config.hide_tab_bar_if_only_one_tab = true

-- config.debug_key_events = true
config.disable_default_key_bindings = true

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, _)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.leader = { key = 'Space', mods = 'ALT' }

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

config.keys = {
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

  -- CTRL-SHIFT-l activates the debug overlay
  { key = 'd', mods = 'LEADER', action = act.ShowDebugOverlay },
  -- CTLR-SHIFT-p activates the Command Palette
  { key = 'p', mods = 'LEADER', action = act.ActivateCommandPalette, },

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

  { key = 'c', mods = 'ALT', action = act.CloseCurrentPane { confirm = false} },

  -- Pane movements, "normal mode"
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left'},
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  -- Activate Pane Select mode
  { key = 'g', mods = 'ALT', action = act.PaneSelect }
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
