local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Poimandres Storm"

config.colors = {
	background = "#252b37",
	cursor_bg = "#607487",
	cursor_border = "#607487",
}

config.font = wezterm.font_with_fallback({
	{ family = "Berkeley Mono", italic = false },
	{ family = "Symbols Nerd Font Mono", scale = 0.75 },
})
config.font_size = 14.0
config.line_height = 1.15
config.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = "Berkeley Mono", style = "Normal" },
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = "Berkeley Mono", italic = false },
		}),
	},
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.macos_window_background_blur = 100
config.window_background_opacity = 0.9
config.window_close_confirmation = "NeverPrompt"

config.window_padding = {
	left = "24px",
	right = "24px",
	top = "1.5cell",
	bottom = "0.5cell",
}

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
