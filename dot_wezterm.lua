-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
-- local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
-- if wezterm.config_builder then
local config = wezterm.config_builder()
-- end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'Monocraft'
config.font_size = 16.0
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
