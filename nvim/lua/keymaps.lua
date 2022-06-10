local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","

-- init.lua management
keymap("n", "<leader>v", ":e $MYVIMRC<cr>", {})
keymap("n", "<leader>V", ":source $MYVIMRC<cr>", {})
keymap("n", "<leader>pi", ":source $MYVIMRC<cr>:PackerSync<cr>", {})

-- quick write and quit
keymap("n", "<leader>w", ":w<cr>", {})
keymap("n", "<leader>q", ":q<cr>", {})

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", {})

-- Turn off highlighting
keymap("n", "<leader><space>", ":noh<cr>", {})

-- Navigate splits
keymap("n", "<down>", "<C-w>j", {})
keymap("n", "<up>", "<C-w>k", {})
keymap("n", "<left>", "<C-w>h", {})
keymap("n", "<right>", "<C-w>l", {})

-- close quickfix list
keymap("n", "<leader>c", ":cclose<cr>", {})

-- Treat long lines as break lines
vim.cmd([[
noremap j gj
noremap k gk
]])

-- Keep indentation when pasting
vim.cmd([[
nnoremap p p=`]
]])

-- Close buffer, but leave split open
keymap("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<cr>", {})

-- Copy paragraphs / blocks of code
vim.cmd([[
noremap cp yap<S-}>p
]])

-- Telescope
vim.cmd([[
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <space> <cmd>lua require('telescope.builtin').buffers()<cr>
]])

-- toggleterm
keymap("n", "<leader>t", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
