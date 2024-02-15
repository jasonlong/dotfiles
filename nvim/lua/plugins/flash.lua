return {
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = true,
          -- keys = { "f", "F", "t", "T" },
          -- search = { wrap = true },
          -- jump = { register = false },
          -- autohide = false,
          -- jump_labels = false,
          -- multi_line = true,

          -- label = {
          --   style = "overlay",
          --   current = false,
          --   after = false,
          --   before = false,
          --   distance = false,
          -- },
          --
          highlight = {
            backdrop = false,
            groups = {
              label = "FlashMatch", -- :hi for f/F
              match = "FlashMatch", -- :hi for t/T
            },
          },
        },
      },
    },
  },
}
