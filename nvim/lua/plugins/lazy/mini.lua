return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- require("mini.jump2d").setup()
		require("mini.pairs").setup()

		local surround = require("mini.surround")
		surround.setup({
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		})

		local indent = require("mini.indentscope")
		indent.setup({
			draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			},
		})

		local animate = require("mini.animate")
		animate.setup({
			cursor = {
				enable = false,
			},
			scroll = {
				timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				-- Animate equally but with at most 120 steps instead of default 60
				subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
			},
			open = {
				enable = false,
			},
			close = {
				enable = false,
			},
			resize = {
				enable = false,
			},
		})
	end,
}
