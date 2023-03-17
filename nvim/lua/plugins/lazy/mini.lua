return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.indentscope").setup()
		require("mini.jump2d").setup()
		require("mini.surround").setup()
	end,
}
