-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_moon"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { italic = false })
config.font_size = 15.0
config.line_height = 1.1

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "RESIZE"

config.window_padding = {
	left = "24px",
	right = "24px",
	top = "1.5cell",
	bottom = "0.5cell",
}

return config
