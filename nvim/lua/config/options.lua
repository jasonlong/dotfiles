-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt
opt.number = true
opt.tabstop = 2
opt.swapfile = false
opt.updatetime = 0
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.smartindent = true
opt.autoindent = true
opt.iskeyword:append("-")
opt.clipboard = "unnamedplus"
opt.smarttab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.incsearch = true
opt.number = true
opt.cmdheight = 1
opt.signcolumn = "yes"

-- vim.cmd([[let $NVIM_TUI_ENABLE_TRUE_COLOR=1]])

vim.cmd([[set termguicolors]])
vim.cmd([[set nocompatible]])
vim.cmd([[set breakindent]])
vim.cmd([[set nobackup]])
vim.cmd([[set nowritebackup]])
vim.cmd([[set lbr]])
vim.cmd([[set ignorecase]])
vim.cmd([[set smartcase]])
vim.cmd([[set wrap]])
vim.cmd([[set magic]])
vim.cmd([[set noerrorbells]])
vim.cmd([[set complete+=kspell]])
vim.cmd([[set completeopt=menu,menuone,noselect]])
vim.cmd([[set mouse=a]])
vim.cmd([[lcd $PWD]])

-- Override LazyVim default options
opt.confirm = false
opt.list = false
opt.conceallevel = 0
