return {
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = true,
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
