local set = vim.opt
set.swapfile = false
set.updatetime = 0
set.encoding="utf-8"
set.fileencoding="utf-8"
set.smartindent = true
set.autoindent = true
set.iskeyword:append("-")
set.clipboard = "unnamedplus"
set.smarttab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.incsearch = true
set.number = true
set.cmdheight = 1
set.signcolumn = "yes"
vim.cmd [[set termguicolors]]
vim.cmd [[set nocompatible]]
vim.cmd [[set breakindent]]
vim.cmd [[set nobackup]]
vim.cmd [[set nowritebackup]]
vim.cmd [[set lbr]]
vim.cmd [[set ignorecase]]
vim.cmd [[set smartcase]]
vim.cmd [[set lazyredraw]]
vim.cmd [[set magic]]
vim.cmd [[set noerrorbells]]
vim.cmd [[set complete+=kspell]]
vim.cmd [[set completeopt=menu,menuone,noselect]]
vim.cmd [[set mouse=a]]
vim.cmd [[lcd $PWD]]

-- Fix eslint errors when saving
vim.cmd [[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]

-- Set formatoptions on each file open since it'll get overwritten by other plugins
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]

vim.opt.formatoptions = {
  ["1"] = true,
  ["2"] = true, -- Use indent from 2nd line of a paragraph
  q = true, -- continue comments with gq"
  c = false, -- Auto-wrap comments using textwidth
  r = false, -- Continue comments when pressing Enter
  n = true, -- Recognize numbered lists
  t = false, -- autowrap lines using text width value
  j = true, -- remove a comment leader when joining lines.
  l = true,
  v = true,
}

-- require('nvim-web-devicons').setup({})
require('impatient')
require("luasnip.loaders.from_snipmate").lazy_load()
require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  update_focused_file = {
    enable  = true
  },
  view = {
    float = {
      enable = true,
      quit_on_focus_loss = true
    }
  }
})
--require('nvim_comment').setup()
require('neoscroll').setup()

require('Comment').setup(
{
  ---@param ctx CommentCtx
  pre_hook = function(ctx)
    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
      local U = require('Comment.utils')

      -- Determine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location,
      })
    end
  end,
})

-- colors
vim.cmd [[colorscheme nord]]
vim.g.nord_contrast = false
vim.g.nord_disable_background = true
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false
require('nord').set()

require('leap').set_default_keymaps()

-- lspconfig
vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = { severity = vim.diagnostic.severity.ERROR }
}

-- filter out node_modules/@types/react/index.d.ts results when jumping to definitions
-- https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.uri, 'react/index.d.ts') == nil
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'tsserver', 'eslint', 'tailwindcss', 'sumneko_lua' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = {
      ['textDocument/definition'] = function(err, result, method, ...)
        if vim.tbl_islist(result) and #result > 1 then
          local filtered_result = filter(result, filterReactDTS)
          return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
        end

        vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
      end
    }
  }
end

-- lualine
nord1 = "#232730"
nord2 = "#2e3440"
nord3 = "#3b4252"
nord5 = "#e5e9f0"
nord6 = "#eceff4"
nord7 = "#8fbcbb"
nord8 = "#88c0d0"
nord14 = "#ebcb8b"

local nord = require'lualine.themes.nord'

nord.normal.a.fg = nord1
nord.normal.a.bg = nord7
nord.normal.b.fg = nord5
nord.normal.b.bg = nord2
nord.normal.c.fg = nord5
nord.normal.c.bg = nord3

nord.insert.a.fg = nord1
nord.insert.a.bg = nord6

nord.visual.a.fg = nord1
nord.visual.a.bg = nord7

nord.replace.a.fg = nord1
nord.replace.a.bg = nord13

nord.inactive.a.fg = nord1
nord.inactive.a.bg = nord7
nord.inactive.b.fg = nord5
nord.inactive.b.bg = nord1
nord.inactive.c.fg = nord5
nord.inactive.c.bg = nord2

require('lualine').setup {
  options = {
    theme = nord,
    component_separators = { left = '·'},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = { {'filename', path = 1} },
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {'filename', path = 1} },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "html", "css", "markdown", "javascript", "typescript", "json", "lua", "prisma", "ruby", "rust", "tsx", "vim", "yaml" },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  autotag = {
    enable = true,
  }
}

-- gitsigns
require('gitsigns').setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '•', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '•', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '•', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '•', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '•', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  current_line_blame_opts = {
    delay = 200,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>B', function() gs.blame_line{full=true} end)
    map('n', '<leader>b', gs.toggle_current_line_blame)
  end
}

-- nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) 
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, 
  }, {
      { name = 'buffer' },
    })
})

-- Telescope
local telescope = require("telescope")
local actions = require('telescope.actions')
local trouble = require("trouble.providers.telescope")
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<esc>"] = actions.close
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["q"] = actions.close
      }
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
      sort_lastused = true
    },
    live_grep = {
      theme = "dropdown",
    }
  }
}

-- toggleterm
require'toggleterm'.setup {
  shade_terminals = false
}
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "html", "css", "markdown", "javascript", "typescript", "json", "lua", "prisma", "ruby", "rust", "tsx", "vim", "yaml" },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true
  },
  context_commentstring = {
    enable = true
  }
}

-- Copilot
vim.cmd [[let g:copilot_no_tab_map = v:true]]
