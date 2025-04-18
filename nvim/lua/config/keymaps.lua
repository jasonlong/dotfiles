-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Unmap keymaps that move lines
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

-- Unmap window moving keymaps
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")

vim.keymap.set("n", "<S-down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<S-up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<S-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<S-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<S-down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<S-up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Unmap keymaps that manage splits
-- vim.keymap.del("n", "<leader>w-")
-- vim.keymap.del("n", "<leader>w|")
-- vim.keymap.del("n", "<leader>wd")
-- vim.keymap.del("n", "<leader>ww")
-- vim.keymap.del("n", "<leader>wm")

-- quicker saving
vim.keymap.set("n", "<leader>ww", ":w<cr>", { desc = "Write buffer" })
vim.keymap.set("n", "<leader>W", ":wall<cr>", { desc = "Write all buffers" })

local neogit = require("neogit")

vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit" })

-- todo-comments
vim.keymap.del("n", "<leader>xt")
vim.keymap.del("n", "<leader>xT")

-- gitlinker
vim.keymap.set({ "n", "v" }, "<leader>gl", "<cmd>GitLink! current_branch<cr>", { desc = "Open current branch" })
vim.keymap.set({ "n", "v" }, "<leader>gL", "<cmd>GitLink! default_branch<cr>", { desc = "Open default branch" })

-- codecompanion
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

-- require("which-key").register({
--   { "<leader>a", group = "CodeCompanion" },
--   { "<leader>a_", hidden = true },
-- })
