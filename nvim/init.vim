call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'jasonlong/nord-vim'
Plug 'karb94/neoscroll.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ruifm/gitlinker.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'akinsho/toggleterm.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Javascript/Typescript
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" For Tailwind
Plug 'neovim/nvim-lspconfig'

" Searching
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'

call plug#end()

let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-snippets',
      \ 'coc-react-refactor',
      \ 'coc-html',
      \ 'coc-eslint',
      \ 'coc-emmet',
      \ 'coc-svg',
      \ 'coc-css',
      \ 'coc-json'
      \ ]

let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme nord

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-reload when edited
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost init.vim source %

nnoremap <leader>v :e $MYVIMRC<CR>
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cd $PWD                           " set pwd to current directory
set termguicolors                 " For truecolor
set history=200                   " Sets how many lines of history VIM has to remember
set autoread                      " Set to auto read when a file is changed from the outside
set wildmenu                      " Tab-complete :b options
set lbr                           " Don't line break in the middle of words
set breakindent                   " Wrapped lines keep indentation
set ttimeout                      " Faster escape timeout
set ttimeoutlen=100
set timeoutlen=3000
set encoding=utf8                 " Set utf8 as standard encoding
set number                        " Show line numnbers
set ruler                         " Show current position
set hid                           " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent    " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                    " Ignore case when searching
set smartcase                     " When searching try to be smart about cases
set hlsearch                      " Highlight search results
set incsearch                     " Makes search act like search in modern browsers
set lazyredraw                    " Don't redraw while executing macros
set magic                         " For regular expressions turn magic on
set showmatch                     " Show matching brackets when text indicator is over them
set mouse=a                       " Allow scrolling in terminal
set guioptions-=r                 " Remove right scrollbar
set go-=L                         " Remove left scrollbar
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set signcolumn=no
set nowb
set noundofile
set signcolumn=yes
set shortmess+=c
set noswapfile
set mat=2                         " How many tenths of a second to blink when matching brackets
set noerrorbells visualbell t_vb= " No annoying sound on errors
set tm=500
autocmd! GUIEnter * set visualbell t_vb=
autocmd BufEnter * syntax sync fromstart

" Tab handling
set expandtab
set shiftwidth=2
set tabstop=2

" Consider more more chars as words for autocomplete
set iskeyword+=-,$

" Turn off blinking cursor in command mode
set gcr=n:blinkon0

set autoindent
filetype plugin indent on

:au FocusLost * silent! wa " Save when focus lost

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
noremap j gj
noremap k gk

" Fast saving
noremap <leader>w :w<CR>

" Keep indentation when pasting
nnoremap p p=`]

" Copy to system clipboard
vnoremap <C-c> "*yy

" Close buffer, but leave split open
nnoremap <Leader>d :bp\|bd #<CR>

" Copy paragraphs / blocks of code
noremap cp yap<S-}>p

" Turn off highlighting
nnoremap <leader><space> :noh<CR>

" Navigate splits
nnoremap <down> <C-w>j
nnoremap <up> <C-w>k
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l

" Close quickfix window
nmap <leader>c :cclose<CR>

" consistent menu navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Make * work with visual selection
vnoremap * y/\V<c-r>=escape(@", '\')<cr><cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lualine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'nvim-tree'.setup {}
EOF
nnoremap <leader>e :NvimTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neoscroll
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('neoscroll').setup({
  easing_function = 'quadratic'
})
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tailwind
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'lspconfig'.tailwindcss.setup{}
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitlinker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require"gitlinker".setup({
  mappings = "<leader>gh"
})
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>s <cmd>Telescope grep_string<cr>
nnoremap <space> <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close
      },
      n = {
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sneak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sneak#s_next=1
let g:sneak#streak=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-better-whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitsigns
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggleterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'toggleterm'.setup {
  shade_terminals = false
}
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Jump to errors
" Requires Option keys to map to Esc+ in iTerm (Profiles > Keys)
nmap <M-j> <Plug>(coc-diagnostic-next)
nmap <M-k> <Plug>(coc-diagnostic-prev)

" React refactor
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
