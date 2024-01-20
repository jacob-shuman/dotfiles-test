local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.color_scheme = 'Tokyo Night'
config.color_scheme = 'Batman'

-- window
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

-- font
config.font = wezterm.font 'Monocraft'
config.font_size = 16.0

-- multiplexing
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    mods   = "LEADER",
    key    = "-",
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    mods   = "LEADER",
    key    = "=",
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    mods = 'LEADER',
    key = 'm',
    action = wezterm.action.TogglePaneZoomState
  },
}

return config
