return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<leader>t", "<cmd>lua _lazygit_toggle()<CR>", noremap = true, silent = true },
	},
	config = function()
		require("toggleterm").setup({
			shade_terminals = false,
		})
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

		function _lazygit_toggle()
			lazygit:toggle()
		end
	end,
}
