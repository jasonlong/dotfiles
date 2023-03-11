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

require("lazy").setup("plugins.lazy")

require("core.options")
require("core.keymaps")
require("core.colorscheme")

require("plugins.lualine")

require("plugins.lsp.lspconfig")
require("plugins.lsp.lspsaga")
require("plugins.lsp.mason")
require("plugins.lsp.null-ls")
