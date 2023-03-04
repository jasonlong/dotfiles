require("nvim-tree").setup({
	git = {
		ignore = false,
	},
	update_focused_file = {
		enable = true,
	},
	view = {
		float = {
			enable = true,
			quit_on_focus_loss = true,
		},
	},
})
