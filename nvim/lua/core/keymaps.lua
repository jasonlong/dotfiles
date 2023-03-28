local map = vim.api.nvim_set_keymap

-- init.lua management
map("n", "<leader>v", ":e $MYVIMRC<cr>", {})
map("n", "<leader>V", ":source $MYVIMRC<cr>", {})

-- quick write and quit
map("n", "<leader>w", ":w<cr>", {})
map("n", "<leader>q", ":q<cr>", {})

-- close buffer
map("n", "<leader>dd", ":bp<bar>sp<bar>bn<bar>bd<cr>", {})
-- close all buffers except current one
map("n", "<leader>da", ":<c-u>up <bar> %bd <bar> e#<cr>", {})

-- Turn off highlighting
map("n", "<esc>", ":noh<cr>", { desc = "Escape and clear hlsearch" })

-- Navigate splits
map("n", "<M-j>", "<C-w>j", {})
map("n", "<M-k>", "<C-w>k", {})
map("n", "<M-h>", "<C-w>h", {})
map("n", "<M-l>", "<C-w>l", {})

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- close quickfix list
map("n", "<leader>c", ":cclose<cr>", {})

-- Treat long lines as break lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

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
map("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<cr>", {})

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Copy paragraphs / blocks of code
vim.cmd([[
noremap cp yap<S-}>p
]])

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Harpoon
map("n", "<leader>ah'", ":lua require('harpoon.mark').add_file()<cr>", {})
map("n", "<leader>am", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", {})
map("n", "<leader>aa", ":lua require('harpoon.ui').nav_file(1)<cr>", {})
map("n", "<leader>as", ":lua require('harpoon.ui').nav_file(2)<cr>", {})
map("n", "<leader>ad", ":lua require('harpoon.ui').nav_file(3)<cr>", {})
map("n", "<leader>af", ":lua require('harpoon.ui').nav_file(4)<cr>", {})

-- Trouble
map("n", "<leader>tt", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>tl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
map("n", "gr", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
