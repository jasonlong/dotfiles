return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  --   config = function()
  --     Nord1 = "#232730"
  --     Nord2 = "#2e3440"
  --     Nord3 = "#3b4252"
  --     Nord5 = "#e5e9f0"
  --     Nord6 = "#eceff4"
  --     Nord7 = "#8fbcbb"
  --     Nord8 = "#88c0d0"
  --     Nord14 = "#ebcb8b"
  --
  --     local nord = require("lualine.themes.nord")
  --
  --     nord.normal.a.fg = Nord1
  --     nord.normal.a.bg = Nord7
  --     nord.normal.b.fg = Nord5
  --     nord.normal.b.bg = Nord2
  --     nord.normal.c.fg = Nord5
  --     nord.normal.c.bg = Nord3
  --
  --     nord.insert.a.fg = Nord1
  --     nord.insert.a.bg = Nord6
  --
  --     nord.visual.a.fg = Nord1
  --     nord.visual.a.bg = Nord7
  --
  --     nord.replace.a.fg = Nord1
  --     nord.replace.a.bg = Nord14
  --
  --     nord.inactive.a.fg = Nord1
  --     nord.inactive.a.bg = Nord7
  --     nord.inactive.b.fg = Nord5
  --     nord.inactive.b.bg = Nord1
  --     nord.inactive.c.fg = Nord5
  --     nord.inactive.c.bg = Nord2
  --
  require("lualine").setup({
    options = {
      theme = poimandres,
      component_separators = { left = "·" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  }),
}
