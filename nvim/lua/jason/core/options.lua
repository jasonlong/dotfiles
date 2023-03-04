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
vim.cmd [[set termguicolors]]
vim.cmd [[set nocompatible]]
vim.cmd [[set breakindent]]
vim.cmd [[set nobackup]]
vim.cmd [[set nowritebackup]]
vim.cmd [[set lbr]]
vim.cmd [[set ignorecase]]
vim.cmd [[set smartcase]]
vim.cmd [[set lazyredraw]]
vim.cmd [[set magic]]
vim.cmd [[set noerrorbells]]
vim.cmd [[set complete+=kspell]]
vim.cmd [[set completeopt=menu,menuone,noselect]]
vim.cmd [[set mouse=a]]
vim.cmd [[lcd $PWD]]

