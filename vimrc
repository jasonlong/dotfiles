" Temp for reloading lavalamp.vim colorscheme
autocmd! bufwritepost lavalamp.vim source %
autocmd! bufwritepost .vimrc source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'justinmk/vim-sneak'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user'
Plug 'whatyouhide/vim-textobj-erb', { 'for': ['ruby', 'eruby'] }
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': ['ruby', 'eruby'] }
Plug 'jasonlong/vim-textobj-css'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'haya14busa/incsearch.vim'
Plug 'ervandew/supertab'
Plug 'justinmk/vim-dirvish'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/clever-f.vim'

" Languages
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'plasticboy/vim-markdown'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'JulesWang/css.vim' " The default syntax repo, but much more up-to-date

" Colors and color tools
Plug 'gerw/vim-HiLinkTrace'
Plug 'chriskempson/base16-vim'

call plug#end()

" Required:
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 256 color support for terminal
set t_Co=256

" no vi compatability
set nocompatible

" set pwd to current directory
cd $PWD

" Enable filetype detection
filetype on

" Enable filetype-specific plugins
filetype plugin on

" Sets how many lines of history VIM has to remember
set history=200

" Set to auto read when a file is changed from the outside
set autoread

" Tab-complete :b options
set wildmenu

" Don't line break in the middle of words
set lbr

" Save when focus lost
:au FocusLost * silent! wa

let mapleader = ","
let g:mapleader = ","

" Fast saving
map <Esc><Esc> :w<CR>
map <leader>w :w<CR>
inoremap jk <esc>

" Keep indentation when pasting
nnoremap p p=`]

" Close buffer, but leave split open
nnoremap <Leader>d :bp\|bd #<CR>

" Copy paragraphs / blocks of code
noremap cp yap<S-}>p

" Keep cursor position after yanking (http://ddrscott.github.io/blog/2016/yank-without-jank/)
vnoremap y myy`y
vnoremap Y myY`y

" Fast access to : commands
nnoremap <Space> :

" Turn off highlighting
nnoremap <leader><space> :noh<CR>

" Easy expansion of current directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <leader>ew :e %%

" bind K to grep (ag) word under cursor
nnoremap K :LAck! "<C-R><C-W>"<CR>

" Faster escape timeout
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set syntax=markdown
au BufRead,BufNewFile *.cocoascript set syntax=javascript
au BufRead,BufNewFile *.sketchplugin set syntax=javascript

" Open all folds by default
au BufRead * normal zR

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>v :e  ~/.vimrc<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore compiled files
set wildignore+=*/tmp/*,*.swp,*.zip,*.gif,*.jpg,*.png,*.sketch,*.psd,.git/*
set wildignore+=*.DS_Store,.tmp/*,.log/*,lib/*,node_modules/*,vendor/*

"Always show current position
set ruler

" Line numbers
set number

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Remove scrollbars
set guioptions-=r " right scrollbar
set go-=L " left scrollbar

" No annoying sound on errors
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set tm=500

" Tab handling
set expandtab
set tabstop=2
set shiftwidth=2

" Consider more more chars as words for autocomplete
set iskeyword+=-,$

" Turn off blinking cursor in command mode
set gcr=n:blinkon0

" Indenting
set smartindent
filetype indent on

" Insert blank lines above and below
nnoremap <D-CR> o<Esc>k
nnoremap <S-D-CR> O<Esc>j

" Increment / decrement numbers
" <C-a> for increment
:nnoremap <C-z> <C-x>

" consistent menu navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Paste from system clipboard
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Mainly used for navigating Syntastic errors
nmap <Down> :lnext<CR>
nmap <Up> :lprevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline =
set statusline +=[%n]                                    " buffer number
set statusline +=\ %F                                    " Full path to file
set statusline +=\ %m                                    " modified flag
set statusline +=%y                                      " Filetype
set statusline +=%=%-14.(%l,%c%V%)                       " Line, column-virtual column
set statusline +=%=lines:\ %-5L                          " Lines in the buffer

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax off

set background=light

if has("gui_running")
  colorscheme lavalamp
  syntax enable
endif

" set guifont=Hack:h14
" set guifont=Operator\ Mono\ Book:h15
" set guifont=Operator\ Mono\ Medium:h16
" set guifont=SF\ Mono\ Regular:h13
set guifont=SF\ Mono\ Medium:h14
set linespace=7

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

nmap <F5> :call ToggleBackgroundColor()<CR>

function! ToggleBackgroundColor()
  if (&background == 'light')
    set background=dark
  else
    set background=light
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noundofile
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Navigate splits
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Fast buffer switching
:nnoremap <D-k> :bprevious<CR>
:nnoremap <D-j> :bnext<CR>

" Use tab and shift-tab to cycle through windows.
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Strip trailing whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Currently stripping for all filetypes
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
vmap <Enter><Enter> :EasyAlign =<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" incsearch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>r :CtrlPMRU<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
let g:ctrlp_use_caching = 1
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" This lets wildignore options work
if exists("g:ctrlp_user_command")
  " unlet g:ctrlp_user_command
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tComment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <D-/> gcc
" vmap <D-/> gc
" " Disable ic text object
" let g:tcommentTextObjectInlineComment = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IndentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>ig :IndentLinesToggle<CR>
let g:indentLine_char = '│'
let g:indentLine_enabled = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimitMate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2
let delimitMate_balance_matchpairs = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>g :LAck!<space>
" let g:ag_lhandler="botright lopen"
" let g:ackprg="/usr/local/bin/ag -U --column --ignore-case --ignore-dir vendor --ignore-dir node_modules --ignore .log --ignore-dir log --ignore-dir tmp --ignore-dir lib"
let g:ackprg="/usr/local/bin/ag --vimgrep --ignore-case --ignore-dir vendor --ignore-dir node_modules --ignore .log --ignore-dir log --ignore-dir tmp --ignore-dir lib"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_scss_checkers = ['stylelint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_filetype_map = { "eruby": "html" }
let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss'] }
let g:syntastic_enable_signs   = 1
let g:syntastic_error_symbol = '×'
let g:syntastic_warning_symbol = '▲'
let g:syntastic_style_error_symbol = '×'
let g:syntastic_style_warning_symbol = '×'
let g:syntastic_html_tidy_ignore_errors = [
      \ "<poll-include-fragment> is not recognized!",
      \ "discarding unexpected <poll-include-fragment>",
      \ "discarding unexpected </poll-include-fragment>",
			\ "trimming empty <span>",
			\ "<svg> is not recognized!",
			\ "discarding unexpected <svg>",
			\ "discarding unexpected </svg>",
			\ "<a> escaping malformed URI reference",
			\ "plain text isn't allowed in <head> elements",
      \ "<li> isn't allowed in <body> elements",
      \ "inserting implicit <ul>",
      \ "missing </ul> before <div>",
      \ "trimming empty <li>",
      \ "trimming empty <ul>",
			\ "missing quote mark for attribute value",
			\ ]

nnoremap <leader>l :SyntasticCheck<CR>

" Make scss-lint traverse up the tree until it finds
" a .scss-lint.yml file.
autocmd FileType css,scss :call SetStylelintConfig()

fun! SetStylelintConfig()
  let b:stylelintConfig = findfile('.stylelintrc.json', '.;')
  if b:stylelintConfig != ''
    let b:syntastic_scss_stylelint_args = '--c ' . b:stylelintConfig
  endif
endf

vnoremap <silent> <leader>s :call StylefmtVisual()<CR>

" Mostly borrowed from:
" https://github.com/kewah/vim-stylefmt/blob/master/plugin/stylefmt.vim
fun! StylefmtVisual() range
  " store current cursor position
  let win_view = winsaveview()

  " get lines from the current selection and store the first line number
  let range_start = line("'<")
  let input = getline("'<", "'>")

  let output = system("stylefmt --config " . b:stylelintConfig, join(input, "\n"))

  if v:shell_error
    echom 'Error while executing stylefmt! no changes made.'
    echo output
  else
    " delete the old lines
    normal! gvd

    let new_lines = split(l:output, '\n')

    " add new lines to the buffer
    call append(range_start - 1, new_lines)

    " Clean up: restore previous cursor position
    call winrestview(win_view)
    " recreate the visual selection and cancel it, so that the formatted code
    " can be reselected using gv
    execute "normal! V" . (len(new_lines)-1) . "j\<esc>"
  endif
endf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-textobj-user
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HiLinkTrace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>h :HLT<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_modified_removed = '□'
let g:gitgutter_sign_modified = '□'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sneak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sneak#s_next=1
let g:sneak#streak=1

