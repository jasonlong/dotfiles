local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader before loading lazy
vim.g.mapleader = ","

require("lazy").setup("plugins")

require("core.options")
require("core.keymaps")
require("core.colorscheme")

--require("jason.plugins.comment")
--require("jason.plugins.gitsigns")
--require("jason.plugins.leap")
--require("jason.plugins.lualine")
--require("jason.plugins.neoscroll")
--require("jason.plugins.nvim-cmp")
--require("jason.plugins.nvim-tree")
--require("jason.plugins.telescope")
--require("jason.plugins.toggleterm")
--require("jason.plugins.treesitter")
--require("jason.plugins.autopairs")
--require("jason.plugins.do")
--
--require("jason.plugins.lsp.mason")
--require("jason.plugins.lsp.lspsaga")
--require("jason.plugins.lsp.lspconfig")
--require("jason.plugins.lsp.null-ls")
