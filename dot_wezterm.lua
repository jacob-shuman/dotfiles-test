local wezterm = require 'wezterm'
local config = wezterm.config_builder()


-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'GitHub Dark'
config.color_scheme = 'Tokyo Night'

-- window
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

-- font
config.font = wezterm.font 'Monocraft'
config.font_size = 16.0

return config
