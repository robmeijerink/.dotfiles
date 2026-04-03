" =========================================================
" Basic Minimal .vimrc - Rob Meijerink
" =========================================================
set nocompatible              " Must be first: disable vi-compatibility
syntax enable                 " Enable syntax highlighting
filetype plugin indent on     " Enable filetype detection and indentation

" --- UI Settings ---
set number                    " Show line numbers
set relativenumber            " Relative numbers for jumping (muscle memory)
set hidden                    " Allow background buffers
set scrolloff=8               " Keep context around cursor
set termguicolors             " True color support
set laststatus=2              " Always show statusline
set cursorline                " Highlight current line

" --- Editing & Indent ---
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab                 " Tabs to spaces
set smartindent               " Better auto-indenting
set backspace=indent,eol,start

" --- Search ---
set incsearch                 " Search as you type
set smartcase                 " Case-insensitive unless caps used
set ignorecase
set nohlsearch                " Don't keep highlights after search

" --- Files & Undo ---
set noswapfile
set undofile                  " Persistent undo
set undodir=~/.vim/undodir    " Ensure this directory exists!
set noerrorbells

" --- Keymaps (Muscle Memory Parity) ---
let mapleader=" "

" Yank to system clipboard (requires +clipboard support in Vim)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg$

" Escaping insert mode
imap <C-c> <Esc>
vmap <C-c> <Esc>

" Consistent Y behavior
nnoremap Y yg$

" Quickfix navigation
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz

" Sudo write
cmap w!! w !sudo tee % > /dev/null
