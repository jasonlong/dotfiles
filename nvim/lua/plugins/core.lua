return {
  -- disable some plugins
  { "RRethy/vim-illuminate", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
        "json",
        "lua",
        "prisma",
        "regex",
        "ruby",
        "rust",
        "svelte",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      level = 3,
      render = "minimal",
      stages = "static",
    },
  },
}
