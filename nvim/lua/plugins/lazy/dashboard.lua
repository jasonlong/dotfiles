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
}
local footer = {
	"",
	" 🚀 Every day matters",
}

return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			config = {
				header = logo,
				packages = { enable = false },
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
