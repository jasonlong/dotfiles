return {
  {
    name = "poimandres",
    dir = "~/.config/nvim/colors/poimandres.nvim",
    lazy = false,
    opts = { style = "storm" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "poimandres",
    },
  },
  -- {
  --   "shaunsingh/nord.nvim",
  --   lazy = false,
  --   config = function()
  --     vim.g.nord_contrast = false
  --     vim.g.nord_disable_background = true
  --     vim.g.nord_italic = false
  --     vim.g.nord_uniform_diff_background = true
  --     vim.g.nord_bold = false
  --
  --     require("nord").set()
  --
  --     -- Alpha startup screen
  --     vim.cmd([[highlight! AlphaHeader guibg=NONE guifg=#4c566a]])
  --     vim.cmd([[highlight! AlphaShortcut guibg=NONE guifg=#a3be8c]])
  --     vim.cmd([[highlight! AlphaFooter guibg=NONE guifg=#5e81ac]])
  --
  --     vim.cmd([[highlight! MiniIndentscopeSymbol guibg=NONE guifg=#3b4252]])
  --     vim.cmd([[highlight! NotifyBackground guibg=#cc0000 ]])
  --     vim.cmd([[highlight! CursorLine guibg=#2e3440]])
  --     vim.cmd([[highlight! CursorColumn guibg=#2e3440]])
  --
  --     vim.cmd([[highlight! NeoTreeFloatBorder guibg=#232730 guifg=#5e81ac]])
  --   end,
  -- },
  --   {
  --     "folke/poimandres.nvim",
  --     lazy = true,
  --     opts = {
  --       style = "moon",
  --       transparent = true,
  --       styles = {
  --         comments = { italic = false },
  --         keywords = { italic = false },
  --       },
  --       on_highlights = function(hl, c)
  --         local prompt = "#2d3149"
  --         hl.TelescopeNormal = {
  --           bg = c.bg_dark,
  --           fg = c.fg_dark,
  --         }
  --         hl.TelescopeBorder = {
  --           bg = c.bg_dark,
  --           fg = c.bg_dark,
  --         }
  --         hl.TelescopePromptNormal = {
  --           bg = prompt,
  --         }
  --         hl.TelescopePromptBorder = {
  --           bg = prompt,
  --           fg = prompt,
  --         }
  --         hl.TelescopePromptTitle = {
  --           bg = prompt,
  --           fg = prompt,
  --         }
  --         hl.TelescopePreviewTitle = {
  --           bg = c.bg_dark,
  --           fg = c.bg_dark,
  --         }
  --         hl.TelescopeResultsTitle = {
  --           bg = c.bg_dark,
  --           fg = c.bg_dark,
  --         }
  --       end,
  --     },
  --   },
}
