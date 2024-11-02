-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha (Gogh)'

config.term = "xterm-256color"
config.enable_wayland = false

-- Config font
config.font = wezterm.font('RobotoMono NerdFont', { weight = 'Regular', italic = false })

config.enable_tab_bar = false

config.font_size = 9.5

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
