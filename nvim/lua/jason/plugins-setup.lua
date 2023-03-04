-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

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
  use 'virchau13/tree-sitter-astro'
  use 'tpope/vim-surround'
  use 'ThePrimeagen/harpoon'
  use 'shaunsingh/nord.nvim'
  use 'jiangmiao/auto-pairs'
  use 'lewis6991/impatient.nvim'
  use 'karb94/neoscroll.nvim'
  use 'ggandor/leap.nvim'
  use 'github/copilot.vim'
  use 'windwp/nvim-ts-autotag'

  -- Git
  use 'akinsho/toggleterm.nvim'
  use 'lewis6991/gitsigns.nvim'

  if packer_bootstrap then
    require("packer").sync()
  end
end)
