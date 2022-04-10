set exrc
set number
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

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'

call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "

nnoremap <leader>u :UndotreeShow<CR>
