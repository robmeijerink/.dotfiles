syntax enable
set number
set relativenumber
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set nohlsearch
set shiftwidth=4
set expandtab
set smartcase
set smartindent
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set termguicolors
set nocompatible
set backspace=indent,eol,start

" Set <leader> key
let mapleader=" "

" Yank to system's clipboard
nnoremap <leader>Y "\"+yg$"
nnoremap <leader>y "\"+y"
vnoremap <leader>y "\"+y"

" Map Ctrl-c to <Esc> for easier mode switching
imap <C-c> <Esc>
vmap <C-c> <Esc>

" Same behavior of Y as D and C: Yank till end of line.
map Y yg$

" Resave with sudo
cmap w!! w !sudo tee %
