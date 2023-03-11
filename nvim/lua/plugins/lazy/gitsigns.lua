return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame_opts = {
				delay = 200,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>B", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>b", gs.toggle_current_line_blame)
			end,
		})
	end,
}
