vim.g.mapleader = ","

local keymap = vim.api.nvim_set_keymap

-- init.lua management
keymap("n", "<leader>v", ":e $MYVIMRC<cr>", {})
keymap("n", "<leader>V", ":source $MYVIMRC<cr>", {})
keymap("n", "<leader>pi", ":source $MYVIMRC<cr>:PackerSync<cr>", {})

-- quick write and quit
keymap("n", "<leader>w", ":w<cr>", {})
keymap("n", "<leader>q", ":q<cr>", {})

-- close buffer
keymap("n", "<leader>dd", ":bp<bar>sp<bar>bn<bar>bd<cr>", {})
-- close all buffers except current one
keymap("n", "<leader>da", ":<c-u>up <bar> %bd <bar> e#<cr>", {})

-- nvim-tree

-- Turn off highlighting
keymap("n", "<leader><space>", ":noh<cr>", {})

-- Navigate splits
keymap("n", "<M-j>", "<C-w>j", {})
keymap("n", "<M-k>", "<C-w>k", {})
keymap("n", "<M-h>", "<C-w>h", {})
keymap("n", "<M-l>", "<C-w>l", {})

-- Move lines up/down (visual mode)
keymap("v", "J", ":m '>+1<cr>gv=gv", {})
keymap("v", "K", ":m '<-2<cr>gv=gv", {})

-- close quickfix list
keymap("n", "<leader>c", ":cclose<cr>", {})

-- Treat long lines as break lines
vim.cmd([[
noremap j gj
noremap k gk
]])

-- Don't yank into system clipboard when changing text
vim.cmd([[
noremap cw "_cw
noremap caw "_caw
noremap ci' "_ci'
noremap ci" "_ci"
noremap ci} "_ci}
noremap ci) "_ci)
]])

-- Close buffer, but leave split open
keymap("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<cr>", {})

-- Copy paragraphs / blocks of code
vim.cmd([[
noremap cp yap<S-}>p
]])

-- Telescope
-- vim.cmd([[
-- nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <space> <cmd>lua require('telescope.builtin').buffers()<cr>
-- ]])

-- Harpoon
vim.cmd([[
nnoremap <silent><leader>m :lua require("harpoon.mark").add_file()<CR>
" These mapping are really for <C-h>, <C-j>, <C-k>, <C-l> and use directions
" because of my Karabiner mapping for <C-j> being down system wide, etc.
nnoremap <silent><left> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><down> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><up> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><right> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><C-;> :lua require("harpoon.ui").nav_file(4)<CR>
]])

-- toggleterm
keymap("n", "<leader>t", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- Copilot
-- vim.cmd([[
-- imap <silent><script><expr> <right> copilot#Accept("\<CR>")
-- ]])

-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
