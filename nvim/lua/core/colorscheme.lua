vim.g.nord_contrast = false
vim.g.nord_disable_background = true
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

require("nord").set()

vim.cmd([[highlight! MiniIndentscopeSymbol guibg=NONE guifg=#3b4252]])
vim.cmd([[highlight! DashboardHeader guibg=NONE guifg=#434C5E]])
