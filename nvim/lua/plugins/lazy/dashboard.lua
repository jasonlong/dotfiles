local logo = {
	"",
	"       .-+#%@@@@@@%#+-.       ",
	"    .+%@@@@@@@@@@@@@@@@%+.    ",
	"  .*@@@@@@@@@@@@@@@@@@@@@@*.  ",
	" -@@@@@@@@@@@@@@@@@@@@@@@@@@: ",
	":@@@@@@@@@@@@@@@@@@@@@@@@@#-  ",
	"%@@@@@@@@@@@@@@@@@@@@@@@*:    ",
	"@@@@@@@@@@@@@@#==+%@@%+.     :",
	"%@@@@@@@@@@@+.  =%@#-      =%@",
	":@@@@@@@@%=  .*@@#:     .+%@@:",
	" -@@@@@#-  -%@@+.     :*@@@@- ",
	"  .*@*:  =@@%=      -#@@@@*.  ",
	"       *@@#:     .+@@@@#+.    ",
	"       :-.     .+%@#+-.       ",
	"",
	"",
	"",
}
local footer = {
	"",
	" 🚀 Every day matters",
}

return {
	"jasonlong/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			config = {
				header = logo,
				disable_move = true,
				packages = { enable = false },
				project = {
					enable = true,
					limit = 8,
					action = ":Telescope find_files cwd=",
				},
				shortcut = {
					{ desc = " Plugins", group = "@property", action = "Lazy update", key = "p" },
					{
						desc = " LSP servers",
						group = "@property",
						action = "Mason",
						key = "l",
					},
					{
						desc = " Health",
						group = "@property",
						action = "checkhealth",
						key = "h",
					},
					{
						desc = " Exit",
						group = "@property",
						action = "quit",
						key = "q",
					},
				},
				footer = footer,
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
