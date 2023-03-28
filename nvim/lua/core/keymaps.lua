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

-- Move lines up/down (visual mode)
map("v", "J", ":m '>+1<cr>gv=gv", {})
map("v", "K", ":m '<-2<cr>gv=gv", {})

-- close quickfix list
map("n", "<leader>c", ":cclose<cr>", {})

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

-- Harpoon
map("n", "<leader>ah'", ":lua require('harpoon.mark').add_file()<cr>", {})
map("n", "<leader>am", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", {})
map("n", "<leader>aa", ":lua require('harpoon.ui').nav_file(1)<cr>", {})
map("n", "<leader>as", ":lua require('harpoon.ui').nav_file(2)<cr>", {})
map("n", "<leader>ad", ":lua require('harpoon.ui').nav_file(3)<cr>", {})
map("n", "<leader>af", ":lua require('harpoon.ui').nav_file(4)<cr>", {})

-- Trouble
map("n", "<leader>tt", "<cmd>Trouble<cr>", { silent = true, noremap = true })
map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>tl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
map("n", "gr", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
