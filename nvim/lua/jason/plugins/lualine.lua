nord1 = "#232730"
nord2 = "#2e3440"
nord3 = "#3b4252"
nord5 = "#e5e9f0"
nord6 = "#eceff4"
nord7 = "#8fbcbb"
nord8 = "#88c0d0"
nord14 = "#ebcb8b"

local nord = require("lualine.themes.nord")

nord.normal.a.fg = nord1
nord.normal.a.bg = nord7
nord.normal.b.fg = nord5
nord.normal.b.bg = nord2
nord.normal.c.fg = nord5
nord.normal.c.bg = nord3

nord.insert.a.fg = nord1
nord.insert.a.bg = nord6

nord.visual.a.fg = nord1
nord.visual.a.bg = nord7

nord.replace.a.fg = nord1
nord.replace.a.bg = nord13

nord.inactive.a.fg = nord1
nord.inactive.a.bg = nord7
nord.inactive.b.fg = nord5
nord.inactive.b.bg = nord1
nord.inactive.c.fg = nord5
nord.inactive.c.bg = nord2

require("lualine").setup({
	options = {
		theme = nord,
		component_separators = { left = "·" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
