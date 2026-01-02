-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.default_domain = 'WSL:Ubuntu-24.04-D'
-- config.color_scheme = 'Tokyo Night'
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 10
-- config.font = wezterm.font_with_fallback {
--    'JetBrains Mono',
--    'Cascade Mono',
-- }
config.colors = {
  cursor_bg = 'silver',
  cursor_border = 'silver',
}

config.hide_tab_bar_if_only_one_tab  = true
config.exit_behavior_messaging  = 'None'
config.window_decorations = 'TITLE|RESIZE'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
