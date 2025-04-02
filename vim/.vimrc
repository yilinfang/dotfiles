" Personal VIM Settings by Yilin Fang
" Basic Settings
syntax on                 " Enable syntax highlighting
set nocompatible          " Use Vim Settings, rathar than Vi settings
set autoread              " Read file when modified outside Vim
set number                " Show line numbers
set relativenumber        " Relative line numbers
set history=1000          " Set the commands to save in the history default number is 20
set wildmenu              " Display command line's tab complete options as a menu
filetype plugin indent on " Enable filetype detection
set list                  " Show invisible characters
set showcmd               " Show partial command in status line
set timeoutlen=500        " Reduce leader key delay (default 1000ms)

set listchars=tab:▸\ ,trail:·,nbsp:␣  " Customize invisibles
set backspace=indent,eol,start " Allow backspacing over everything

" Tab/Indentation
set tabstop=4             " Show existing tab as 4 spaces
set shiftwidth=4          " Indent using 4 spaces
set expandtab             " Convert tabs to spaces
set autoindent            " Maintain indent of current line
set smartindent           " Context-aware indentation
set smarttab              " Smart tab

" Search
set ignorecase            " Case-insensitive search
set smartcase             " Case-sensitive when using capitals
set incsearch             " Show partial matches
set hlsearch              " Highlight matches

" Interface
set mouse=a               " Enable mouse support
set encoding=utf-8        " Set default encoding
set laststatus=4          " Always show status line
set ruler                 " Show cursor position
set cursorline            " Highlight current line
set wrap                  " Wrap long lines
set linebreak             " Break at word boundaries
set title                 " Show filename in terminal title
set termguicolors         " Enable true colors (if terminal supports it)
set scrolloff=10          " Keep 10 lines above/below cursor
set sidescrolloff=5       " Keep 5 columns beside cursor horizontally

" Buffer & Window Management
set hidden                " Allow switching buffers without saving
set splitbelow splitright " More natural split placement (below/right)

" Completion
set completeopt=menu,menuone,noselect

" Custom minimal status line
set statusline=%F%m%r%h%w\ [%{&ff}/%Y]\ %=[%l,%c]\ [%p%%]

" Backup/swap files
set nobackup
set noswapfile

" Visual preferences
colorscheme torte         " Built-in color scheme
set background=dark       " Use colors that suit a dark background
set signcolumn=yes        " Always show sign column

" Key Mappings
let mapleader = " "       " Set leader key to space

" Redo
nnoremap <leader>r <C-r>

" Quick Navigate
nnoremap <leader>u <C-u>
nnoremap <leader>d <C-d>

" Select ALL
nnoremap <M-A> ggVG

" Copy to System Clipboard +
xnoremap <M-C> "+y

" Quick save/quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlights
nnoremap <silent> <leader>H :nohlsearch<CR>

" Move the current line with Option/Alt + k/j
nnoremap <M-k> :m .-1<CR>==
nnoremap <M-j> :m .+2<CR>==
vnoremap <M-k> :m '<-1<CR>gv=gv
vnoremap <M-j> :m '>+2<CR>gv=gv

" Backup mappings using Ctrl + Shift + k/j
nnoremap <C-K> :m .-1<CR>==
nnoremap <C-J> :m .+2<CR>==
vnoremap <C-K> :m '<-1<CR>gv=gv
vnoremap <C-J> :m '>+2<CR>gv=gv

" Easier window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Splits management
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <leader>sc :close<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Toggle fold under cursor
nnoremap <leader>z za
" Open all folds
nnoremap <leader>zo zR
" Close all folds
nnoremap <leader>zc zM

" Filetype-specific settings
augroup configgroup
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType sh setlocal tabstop=2 shiftwidth=2
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
    autocmd FileType toml setlocal tabstop=2 shiftwidth=2
    autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
