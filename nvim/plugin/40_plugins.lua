-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
	add({
		'https://github.com/nvim-treesitter/nvim-treesitter',
		'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
	})
	Config.on_packchanged('nvim-treesitter', { 'update' }, function() vim.cmd('TSUpdate') end, ':TSUpdate')

	-- Define languages which will have parsers installed and auto enabled
	local languages = {
		-- These are already pre-installed with Neovim. Used as an example.
		"lua",
		"vimdoc",
		"markdown",
		-- Frontend web development
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"json",
		-- Add here more languages with which you want to use tree-sitter
		-- To see available languages:
		-- - Execute `:=require('nvim-treesitter').get_available()`
		-- - Visit 'SUPPORTED_LANGUAGES.md' file at
		--   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
	}
	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end
	local to_install = vim.tbl_filter(isnt_installed, languages)
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
	end

	-- Enable tree-sitter after opening a file for a target language
	local filetypes = {}
	for _, lang in ipairs(languages) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end
	local ts_start = function(ev)
		vim.treesitter.start(ev.buf)
	end
	Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

	-- Context-aware commentstring (for JSX, TSX, HTML, etc.)
	add({ 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' })
	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})

	-- Auto-rename and auto-close HTML/JSX tags
	add({ 'https://github.com/windwp/nvim-ts-autotag' })
	require("nvim-ts-autotag").setup()
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
	add({ 'https://github.com/neovim/nvim-lspconfig' })

	-- Use `:h vim.lsp.enable()` to automatically enable language server based on
	-- the rules provided by 'nvim-lspconfig'.
	-- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
	-- Install servers via Mason: `:MasonInstall typescript-language-server html-lsp
	-- css-lsp tailwindcss-language-server eslint-lsp emmet-language-server`
	vim.lsp.enable({
		"ts_ls", -- TypeScript/JavaScript (covers JSX/TSX/React)
		"html", -- HTML
		"cssls", -- CSS
		"tailwindcss", -- Tailwind CSS
		"eslint", -- ESLint diagnostics and auto-fix
		"emmet_language_server", -- Emmet abbreviations
		"biome", -- Biome (linter/formatter, used when biome.json exists)
	})
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
--
-- Install formatters: `npm install -g @fsouza/prettierd eslint_d`
-- Or via Mason: `:MasonInstall prettierd eslint_d`
later(function()
	add({ 'https://github.com/stevearc/conform.nvim' })

	-- See also:
	-- - `:h Conform`
	-- - `:h conform-options`
	-- - `:h conform-formatters`
	require("conform").setup({
		-- Use LSP as fallback when no formatter is configured
		default_format_opts = {
			lsp_format = 'fallback',
		},
		-- Format after save (async, non-blocking)
		format_after_save = {},
		-- Override biome to use `check --write` which runs formatting,
		-- linting fixes, and organize imports all in one pass.
		-- Only run biome when a config file exists in the project.
		formatters = {
			biome = {
				args = { "check", "--write", "--unsafe", "$FILENAME" },
				stdin = false,
				condition = function(_, ctx)
					return vim.fs.find({ "biome.json", "biome.jsonc" }, {
						path = ctx.filename,
						upward = true,
					})[1] ~= nil
				end,
			},
		},
		-- Map of filetype to formatters
		-- Biome first (if available), then prettier/eslint as fallback
		formatters_by_ft = {
			javascript = { "biome", "prettierd", "eslint_d", stop_after_first = true },
			typescript = { "biome", "prettierd", "eslint_d", stop_after_first = true },
			javascriptreact = { "biome", "prettierd", "eslint_d", stop_after_first = true },
			typescriptreact = { "biome", "prettierd", "eslint_d", stop_after_first = true },
			json = { "biome", "prettierd", stop_after_first = true },
			html = { "prettierd" },
			css = { "biome", "prettierd", stop_after_first = true },
			markdown = { "prettierd" },
			lua = { "stylua" },
		},
	})
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function()
	add({ 'https://github.com/rafamadriz/friendly-snippets' })
end)

-- Mason =======================================================================

-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
--
-- Use `:Mason` to open the Mason UI, `:MasonInstall <package>` to install.
later(function()
	add({ 'https://github.com/mason-org/mason.nvim' })
	require("mason").setup()
end)

-- Leap ========================================================================

-- Fast motion plugin. Jump to any location by typing 2 characters.
-- Usage: `<CR>` to start leap, then type 2 characters to jump
later(function()
	add({ 'https://codeberg.org/andyg/leap.nvim' })

	vim.keymap.set("n", ";", "<Plug>(leap)", { desc = "Leap" })
end)

-- Neogit ======================================================================

-- A Magit-inspired Git interface for Neovim. Provides a rich UI for staging,
-- committing, branching, and other Git operations.
--
-- Usage: `:Neogit` or `<Leader>gn` to open
later(function()
	add({ 'https://github.com/nvim-lua/plenary.nvim' })
	add({ 'https://github.com/sindrets/diffview.nvim' })
	add({ 'https://github.com/NeogitOrg/neogit' })
	require("neogit").setup({
		use_per_project_settings = false, -- avoids vim.uv.cwd() nil error
	})

	vim.keymap.set("n", "<Leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
end)

