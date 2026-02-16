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

local wsl_domains = wezterm.default_wsl_domains()
local is_wsl = wsl_domains ~= nil and #wsl_domains > 0
local is_macos = wezterm.target_triple:find("darwin") ~= nil

-- For example, changing the color scheme:
if is_wsl then
  for _, dom in ipairs(wsl_domains) do
    if dom.name == 'WSL:Ubuntu-24.04-D' then
      config.default_domain = dom.name
    end
  end
  if config.default_domain == nil then
    wezterm.log_info('WSL domain not found, using default shell')
  end
end
-- config.color_scheme = 'Tokyo Night'
config.initial_cols = 120
config.initial_rows = 28
config.harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'}
config.font_size = 12

if is_wsl then
  config.font = wezterm.font_with_fallback {
     'Cascadia Mono',
  }
elseif is_macos then
  config.font = wezterm.font_with_fallback {
     'Monaco',
  }
end

config.colors = {
  cursor_bg = 'silver',
  cursor_border = 'silver',
}

config.hide_tab_bar_if_only_one_tab  = true
config.exit_behavior_messaging  = 'None'
config.window_decorations = 'TITLE|RESIZE'
config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}

config.window_close_confirmation = 'NeverPrompt'

config.keys = {
  { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'CMD', action = wezterm.action.PasteFrom 'Clipboard' },
}

-- and finally, return the configuration to wezterm
return config
