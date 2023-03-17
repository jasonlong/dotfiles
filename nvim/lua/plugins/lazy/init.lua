return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},
	"nvim-tree/nvim-web-devicons",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"virchau13/tree-sitter-astro",
	"tpope/vim-surround",
	"ThePrimeagen/harpoon",
	"shaunsingh/nord.nvim",
	"jiangmiao/auto-pairs",
	"github/copilot.vim",
	"nocksock/do.nvim",

	-- Autocomplete
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"onsails/lspkind.nvim",

	-- Snippets
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- configuring lsp servers
	"neovim/nvim-lspconfig",
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	"jose-elias-alvarez/typescript.nvim",

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",

	-- auto closing parens, etc.
	"windwp/nvim-autopairs",
}
