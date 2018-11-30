set nocompatible        " Use Vim defaults (much better!)
set noedcompatible
set modeline            " Read configuration from inside loaded files
set modelines=5         " Scan up to 5 lines for a modeline
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set autoindenting on
set tw=0                " Don't wrap lines
set wrap                " Display long lines wrapped.
set viminfo='20,\"50    " Read/write a .viminfo file, don't store more than 50 lines of register
set cmdheight=2         " Height of the command line (the one at the bottom)
set background=light    " Switch this to dark for dark terminals
set vb                  " Use visual bell instead of a sound
set t_vb=
set title               " Set the window title
set autowriteall        " Write changed files on exit
set autoread            " Re-read files that changed on disk
set showmatch           " Highlight matching brackets
set showcmd             " Show (partial) command in the last line of the screen
set number              " Show line number on the left side of the buffer.
set ruler               " Show the line and column number of the cursor position.
set laststatus=2        " Always show a status line.
set scrolloff=4         " Minimal number of screen lines to keep above and below the cursor.
set hidden              " Allow several buffers to be opened (and unsaved).
set tabstop=2           " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2        " Number of spaces to use for each step of (auto)indent.
set softtabstop=2       " Number of spaces that a <Tab> counts for while performing editing operations.
set expandtab           " Use the appropriate number of spaces to insert a <Tab>.
set ignorecase          " Case-insensitive search
set incsearch           " Incremental search shows the first match while typing the search pattern.
set smartcase           " Override the 'ignorecase' option if the search pattern contains upper case characters.
set confirm             " Use confirmation dialogs.
set encoding=utf-8      " The terminal encoding.
set fileencodings=utf-8,default,latin1  " The order of file encodings to try.
set shell=/bin/sh       " Always use sh when executing commands with :!
set wildmenu            " Command-line completion operates in an enhanced mode.
set wildmode=list:longest,list:full
set guifont=Menlo\ Regular:h14
                        " Completion mode.
set list                " List mode: Show tabs as CTRL-I, show end of line with $.
set listchars=tab:»\ ,extends:¤,trail:·
                        " Strings to use in 'list' mode.
set colorcolumn=100

" Activate syntax highlighting unless for vimdiff
if !&diff
  syntax on
  syntax sync fromstart
endif
set hlsearch            " Highlight all search matches.

filetype on             " Enable filetype detection
filetype indent on      " Enable filetype-specific indenting
filetype plugin on      " Enable filetype-specific plugins

" Search for the string marked in visual mode. E.g.: press v, go some chars to the right, press /
vmap / y/<C-R>"<CR>

" Don't use Ex mode, use Q for formatting
map Q gq
" Ctrl-p: previous buffer
map <C-p> :bp<CR>
" Ctrl-n: next buffer
map <C-n> :bn<CR>
" Go over wrapped lines with j and k. These will jump to the next/previous
" displayed line instead of the next/previous physical line.
map j gj
map k gk
" Switch to next visible buffer.
map <TAB> <C-W>w
augroup DeleteTrailingWhitespaces
  autocmd!
  autocmd BufWritePre * ks|execute "%s/\\s\\+$//ge"|'s
augroup END

augroup TabWidth
  autocmd! FileType objc,tcl,java,php  setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END

augroup Objc
  autocmd! FileType matlab set filetype=objc
augroup END

augroup Java
  autocmd! FileType java setlocal path+=Java/*/src/**
augroup END

au BufNewFile,BufRead [rR]antfile,*.rant,[rR]akefile,*.rake setf ruby
au BufNewFile,BufRead *.sass setf sass
au BufNewFile,BufRead *.ejs setf eruby

set noeol

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

"
" ### ### Vim-Plugged
"
call plug#begin('~/.vim/plugged')

"
" ### Basic plugins
"

Plug 'Numkil/ag.nvim' " 'ag' integration
Plug 'Raimondi/delimitMate' " Automatically close the parethesis
Plug 'airblade/vim-gitgutter' " Show which lines were modified
Plug 'altercation/vim-colors-solarized' " Colors cheme
Plug 'cloudhead/neovim-fuzzy' " Fuzzy search
Plug 'godlygeek/tabular' " Table formatting
Plug 'prettier/vim-prettier', {'do': 'yarn install'} " Prettier bindings
Plug 'scrooloose/nerdtree' " Nerdtree
Plug 'vim-airline/vim-airline' " Better status bar
Plug 'vim-airline/vim-airline-themes' " Status bar themes

"
" ### Language specific integrations
"

" Ruby
Plug 'vim-ruby/vim-ruby'

" JavaScript
Plug 'jelera/vim-javascript-syntax'

" NeoVim TypeScript support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'

call plug#end()

filetype plugin indent on
set t_Co=256

" vim-colors-solarized
colorscheme solarized

" nerdtree
let NERDTreeMapActivateNode="y"
function! NextTab()
  exe "normal \<C-W>\<C-w>"
endfunction
autocmd VimEnter * call NextTab()

" TypeScript / deoplete
nmap <silent> <c-t> :TSType<CR>
nmap <silent> <c-d> :TSDefPreview<CR>
let g:deoplete#enable_at_startup = 1

" Prettier
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Fuzzy search
nnoremap <C-p> :FuzzyOpen<CR>

autocmd BufNewFile,BufRead *.es6 set syntax=javascript

set dir=$HOME/.vimtmp/swap//
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif
