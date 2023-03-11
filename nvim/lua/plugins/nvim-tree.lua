return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>e", ":NvimTreeToggle<cr>" },
	},
	config = function()
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
	end,
}
