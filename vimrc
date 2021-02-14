"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Packages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Core
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('Raimondi/delimitMate')
call minpac#add('ntpeters/vim-better-whitespace')
call minpac#add('djoshea/vim-autoread')

" Getting around
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('justinmk/vim-sneak')
call minpac#add('rhysd/clever-f.vim')
call minpac#add('mhinz/vim-grepper')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('matze/vim-move')
call minpac#add('sickill/vim-pasta')
call minpac#add('AndrewRadev/whitespaste.vim')

" textobj stuff
call minpac#add('kana/vim-textobj-user')
call minpac#add('whatyouhide/vim-textobj-erb')
call minpac#add('whatyouhide/vim-textobj-xmlattr')
call minpac#add('nelstrom/vim-textobj-rubyblock')
call minpac#add('jasonlong/vim-textobj-css')

" Colors
call minpac#add('jasonlong/nordish-vim')

" Languages
call minpac#add('JulesWang/css.vim') " The default syntax repo, but more up-to-date
call minpac#add('pangloss/vim-javascript')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('prettier/vim-prettier')
call minpac#add('Chiel92/vim-autoformat') " Using for html-beautify via js-beautify
call minpac#add('leafgarland/typescript-vim')

command! Pu source $MYVIMRC | call minpac#update()
command! Pc source $MYVIMRC | call minpac#clean()

let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-reload when edited
autocmd! bufwritepost .vimrc source %

nnoremap <leader>v :e $MYVIMRC<CR>
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cd $PWD                           " set pwd to current directory
set t_Co=256                      " 256 color support for terminal
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
set lazyredraw                    " Helps with scrolling performance
set mouse=a                       " Allow scrolling in terminal
set guioptions-=r                 " Remove right scrollbar
set go-=L                         " Remove left scrollbar
set nobackup
set nowb
set noundofile
set noswapfile
set mat=2                         " How many tenths of a second to blink when matching brackets
set noerrorbells visualbell t_vb= " No annoying sound on errors
set tm=500
autocmd! GUIEnter * set visualbell t_vb=
if has('nvim')
  set inccommand=nosplit          " Live preview of substitutions
endif

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

filetype on " Enable filetype detection
filetype plugin on " Enable filetype-specific plugins
:au FocusLost * silent! wa " Save when focus lost

" .gf files == .tf
autocmd BufRead,BufNewFile *.gf set filetype=tf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
noremap j gj
noremap k gk

" Fast saving
noremap <leader>w :w<CR>

" Keep indentation when pasting
" nnoremap p p=`]

" Copy to system clipboard
vnoremap <C-c> "*yy

" Close buffer, but leave split open
nnoremap <Leader>d :bp\|bd #<CR>

" Copy paragraphs / blocks of code
noremap cp yap<S-}>p

" Turn off highlighting
nnoremap <leader><space> :noh<CR>

" Navigate splits
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Close quickfix window
nmap <leader>c :cclose<CR>

" Use tab and shift-tab to cycle through windows.
" nnoremap <Tab> <C-W>w
" nnoremap <S-Tab> <C-W>W

" consistent menu navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>


" Make * work with visual selection
vnoremap * y/\V<c-r>=escape(@", '\')<cr><cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark
colorscheme nordish

if has("gui_running")
  set macligatures
  set guifont=Hasklig\ Medium:h14
  set linespace=2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline =
set statusline +=[%n]              " buffer number
set statusline +=\ %F              " Full path to file
set statusline +=\ %m              " modified flag
set statusline +=%y                " Filetype
set statusline +=%=%-14.(%l,%c%V%) " Line, column-virtual column
set statusline +=%=lines:\ %-5L    " Lines in the buffer

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
nmap <Leader>r :FZFMru<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grepper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:grepper = {}
let g:grepper.tools = ['rg']
let g:grepper.rg = { 'grepprg': 'rg --no-heading --vimgrep --smart-case' }

nnoremap <leader>g :Grepper<cr>
nnoremap K :Grepper -cword -noprompt<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-textobj-user
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimitMate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2
let delimitMate_balance_matchpairs = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sneak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sneak#s_next=1
let g:sneak#streak=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clever-f
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clever_f_timeout_ms = 2000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_removed = '•'

" Remap these as they conflict w/ vim-textobj-css
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " prettier
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:prettier#autoformat_require_pragma = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType jsx setlocal commentstring={/*\ %s\ */}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-better-whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-move
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:move_key_modifier = 'C'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=300
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
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

" Use K to show documentation in preview window.
nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

