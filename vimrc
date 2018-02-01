"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Packages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Core
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-commentary')
call minpac#add('Raimondi/delimitMate')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('ntpeters/vim-better-whitespace')
call minpac#add('ervandew/supertab')
call minpac#add('w0rp/ale')
call minpac#add('SirVer/ultisnips')

" Getting around
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('justinmk/vim-sneak')
call minpac#add('rhysd/clever-f.vim')
call minpac#add('mhinz/vim-grepper')
call minpac#add('justinmk/vim-dirvish')

" textobj stuff
call minpac#add('kana/vim-textobj-user')
call minpac#add('whatyouhide/vim-textobj-erb')
call minpac#add('whatyouhide/vim-textobj-xmlattr')
call minpac#add('nelstrom/vim-textobj-rubyblock')
call minpac#add('jasonlong/vim-textobj-css')

" Colors
call minpac#add('jasonlong/nordish-vim')
call minpac#add('reedes/vim-colors-pencil')

" Languages
call minpac#add('JulesWang/css.vim') " The default syntax repo, but more up-to-date
call minpac#add('pangloss/vim-javascript')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('mxw/vim-jsx')
call minpac#add('fatih/vim-hclfmt') " For Tarraform-type Files
call minpac#add('prettier/vim-prettier')

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

" Consider more more chars as words for autocomplete
set iskeyword+=-,$

" Turn off blinking cursor in command mode
set gcr=n:blinkon0

set autoindent
set smartindent
filetype indent on

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
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Close quickfix window
nmap <leader>c :cclose<CR>

" Use tab and shift-tab to cycle through windows.
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

" consistent menu navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Make * work with visual selection
vnoremap * y/\V<c-r>=escape(@", '\')<cr><cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
  set termguicolors
endif

syntax on
set background=dark
" let g:nord_comment_brightness=15 " more contrast for comments
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
" Easy Align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To align around double quote, use `ga"`
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)
" vmap <Enter><Enter> :EasyAlign =<CR>

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
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '×'
let g:ale_sign_warning = '▲'
let g:ale_set_loclist = 0

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" stylefmt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css,scss :call SetStylelintConfig()
au FileType css,scss vnoremap <buffer> <leader>s :call StylefmtVisual()<CR>

fun! SetStylelintConfig()
  let b:stylelintConfig = findfile('.stylelintrc', '.;')
  if b:stylelintConfig != ''
    let b:syntastic_scss_stylelint_args = '--config ' . b:stylelintConfig
  endif
endf

function! StylefmtVisual() range
  " store current cursor position and change the working directory
  let win_view = winsaveview()
  let file_wd = expand('%:p:h')
  let current_wd = getcwd()
  execute ':lcd' . file_wd

  " get lines from the current selection and store the first line number
  let range_start = line("'<")
  let input = getline("'<", "'>")

  let output = system("stylefmt --config " . b:stylelintConfig, join(input, "\n"))
  echom output

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

  " Clean up: restore working directory
  execute ':lcd' . current_wd
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-better-whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! BufEnter * EnableStripWhitespaceOnSave

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
