-- return {
--   "shaunsingh/nord.nvim",
--   config = function()
--     vim.g.nord_contrast = false
--     vim.g.nord_disable_background = true
--     vim.g.nord_italic = false
--     vim.g.nord_uniform_diff_background = true
--     vim.g.nord_bold = false
--
--     require("nord").set()
--
--     vim.cmd([[highlight! MiniIndentscopeSymbol guibg=NONE guifg=#3b4252]])
--     vim.cmd([[highlight! DashboardHeader guibg=NONE guifg=#434C5E]])
--     vim.cmd([[highlight! NotifyBackground guibg=#cc0000 ]])
--     vim.cmd([[highlight! CursorLine guibg=#2e3440]])
--     vim.cmd([[highlight! CursorColumn guibg=#2e3440]])
--
--     vim.cmd([[highlight! NeoTreeFloatBorder guibg=#232730 guifg=#5e81ac]])
--   end,
-- }

return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    },
  },
}
