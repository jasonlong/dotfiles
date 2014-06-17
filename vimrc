" Temp for reloading lavalamp.vim colorscheme
autocmd! bufwritepost lavalamp.vim source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=/Users/jason/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/Users/jason/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
  \   'windows': 'make -f make_mingw32.mak',
  \   'cygwin': 'make -f make_cygwin.mak',
  \   'mac': 'make -f make_mac.mak',
  \   'unix': 'make -f make_unix.mak',
  \ } }

" My Bundles here:
NeoBundle 'Indent-Guides'
NeoBundle 'Lokaltog/vim-easymotion.git'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-ruby/vim-ruby'

" Languages
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'othree/html5.vim'

" Colors and color tools
NeoBundle 'sjl/badwolf'
NeoBundle 'Solarized'
NeoBundle 'tomasr/molokai'
NeoBundle '29decibel/codeschool-vim-theme'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'gerw/vim-HiLinkTrace'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" no vi compatability
set nocompatible

" set pwd to current directory
cd $PWD

" Enable filetype detection
filetype on

" Enable filetype-specific indenting
filetype indent on

" Enable filetype-specific plugins
filetype plugin on

" Sets how many lines of history VIM has to remember
set history=200

" Set to auto read when a file is changed from the outside
set autoread

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

" Close buffer, but leave split open
nnoremap <Leader>d :bp\|bd #<CR>

" Fast buffer switching
:nnoremap <F1> :bprevious<CR>
:nnoremap <F2> :bnext<CR>

" Fast access to : commands
nnoremap <Space> :

" Turn off highlighting
nnoremap <leader><space> :noh<CR>

" Easy expansion of current directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Faster escape timeout
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

" CSScomb
nnoremap <leader>c :silent !php ~/dev/csscomb/csscomb.php -i %<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set syntax=markdown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>v :e  ~/.vimrc<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,.git\*,.hg\*,.svn\*

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
" set noerrorbells
" set novisualbell
" set t_vb=
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set tm=500

" Tab handling
set expandtab
set tabstop=2
set shiftwidth=2

" Highlight current line
set cursorline

" Turn off blinking cursor in command mode
set gcr=n:blinkon0

" Indenting
set smartindent
filetype indent on

" Insert blank lines above and below
nnoremap <CR> o<Esc>k
nnoremap <s-CR> O<Esc>j

" Increment / decrement numbers
" <C-a> for increment
:nnoremap <C-z> <C-x>

" Navigate splits
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" consistent menu navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set background=dark
colorscheme lavalamp
" set guifont=Consolas\ for\ Powerline:h17
set guifont=CamingoCode\ for\ Powerline:h17

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile
set undofile
set undolevels=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

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
" EasyMotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
map f <Plug>(easymotion-bd-f)
map / <Plug>(easymotion-sn)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_source_rec_max_cache_files = 5000
call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '\(\.git$\|\.png$\|\.eot$\|\.woff$\|\.ttf$\|\.gpg$\|\.swf$\|\.ico$\|\.gif$\|\.jpg$\)')
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 5000)
let g:unite_source_history_yank_enable = 1
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --ignore-case --column --ignore vendor/ --ignore .log'
  let g:unite_source_grep_recursive_opt = ''
endif
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>g :<C-u>Unite -no-split grep:.<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <buffer> Q <plug>(unite_exit)
  " nmap <buffer> <esc> <plug>(unite_exit)
  " imap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <tab> <plug>(unite_do_default_action)
  nmap <buffer> <tab> <plug>(unite_do_default_action)
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tComment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <D-/> gcc
vmap <D-/> gc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent Guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_guide_size = 1
"Toggle with <Leader>ig

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>a :Ag<space>
let g:agprg="/opt/boxen/homebrew/bin/ag --column --ignore-case --ignore vendor/ --ignore .log"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_scss_checkers = ['scss_lint']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='lavalamp'
let g:airline_section_x=""
let g:airline_section_y="%{strlen(&ft)?&ft:'none'}"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-textobj-user
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HiLinkTrace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>h :HLT<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<C-a>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplcache
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_force_overwrite_completefunc = 1

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
