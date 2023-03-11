return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
		{ "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
		{ "<space>", "<cmd>lua require('telescope.builtin').buffers()<cr>" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local trouble = require("trouble.providers.telescope")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<c-t>"] = trouble.open_with_trouble,
						["<esc>"] = actions.close,
					},
					n = {
						["<c-t>"] = trouble.open_with_trouble,
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--ignore",
						"-u",
						"--glob=!**/.git/*",
						"--glob=!**/node_modules/*",
					},
				},
				buffers = {
					theme = "dropdown",
					sort_lastused = true,
				},
				live_grep = {
					theme = "dropdown",
				},
			},
		})
	end,
}