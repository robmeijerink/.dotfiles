local Plug = vim.fn['plug#']

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

vim.call('plug#begin', '~/.vim/plugged')

-- Theme
Plug 'gruvbox-community/gruvbox'

-- Basics
Plug 'kdheepak/lazygit.nvim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug '907th/vim-auto-save'
Plug 'machakann/vim-highlightedyank'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('akinsho/bufferline.nvim', {tag = '*'})

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

-- File Explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

-- Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- JavaScript
Plug('HerringtonDarkholme/yats.vim', {ft = 'typescript'})
Plug 'posva/vim-vue' -- Vue highlighting
Plug 'othree/javascript-libraries-syntax.vim'

vim.call('plug#end')

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Theme settings
vim.cmd('colorscheme gruvbox')
vim.cmd('highlight Normal guibg=none')