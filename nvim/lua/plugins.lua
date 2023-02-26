return require('packer').startup(function()
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  use 'nvim-tree/nvim-web-devicons'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'nvim-treesitter/playground'
  use 'tpope/vim-surround'
  use 'ThePrimeagen/harpoon'
  use 'wbthomason/packer.nvim'
  use 'shaunsingh/nord.nvim'
  use 'jiangmiao/auto-pairs'
  use 'lewis6991/impatient.nvim'
  use 'karb94/neoscroll.nvim'
  use 'ggandor/leap.nvim'
  use 'github/copilot.vim'
  use 'windwp/nvim-ts-autotag'
  use 'virchau13/tree-sitter-astro'

  -- Git
  use 'akinsho/toggleterm.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- Autocomplete
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
end)

