return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
	dependencies = { "windwp/nvim-ts-autotag" },

	keys = {
		{ "<leader>e", ":NvimTreeToggle<cr>" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"astro",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"javascript",
				"typescript",
				"json",
				"lua",
				"prisma",
				"ruby",
				"rust",
				"tsx",
				"vim",
				"yaml",
			},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			playground = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			auto_install = true,
		})
	end,
}
