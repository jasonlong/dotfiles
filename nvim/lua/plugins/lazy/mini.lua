return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.jump2d").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()

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
