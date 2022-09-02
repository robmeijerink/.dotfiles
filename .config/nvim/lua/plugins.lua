local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- stylua: ignore start
return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Colorscheme section
    -- use { "ellisonleao/gruvbox.nvim" }
    use("folke/tokyonight.nvim")
    -- use {
    --     "EdenEast/nightfox.nvim",
    --     run = ":NightfoxCompile",
    --     config = function ()
    --         require('nightfox').setup({
    --              options = {
    --                     -- Compiled file's destination location
    --                     transparent = true,    -- Disable setting background
    --                     terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    --                     dim_inactive = false
    --                 }
    --             }
    --         )
    --     end
    -- }
    -- use { "tanvirtin/monokai.nvim" }
    -- Plugins
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        event = "BufWinEnter",
        config = "require('treesitter-config')"
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = "nvim-treesitter" } -- Additional textobjects for treesitter
    use { 'nvim-treesitter/nvim-treesitter-context', after = "nvim-treesitter" } -- Sticky header for functions
    use {
        'pocco81/auto-save.nvim',
        config = "require('autosave-config')"
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = "require('lualine-config')",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        event = "BufWinEnter",
        config = "require('bufferline-config')"
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        cmd = "NvimTreeToggle",
        config = "require('nvim-tree-config')"
    }
    use { "lewis6991/impatient.nvim", config = "require('impatient-config')" }
    use { "moll/vim-bbye" }
    use { 'mbbill/undotree' }
    use { 'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter" }
    use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
    use { 'windwp/nvim-autopairs', config = "require('autopairs-config')", after = "nvim-cmp" }
    use { 'folke/which-key.nvim', config = "require('whichkey-config')" }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' }f, { "kdheepak/lazygit.nvim" } },
        cmd = "Telescope",
        config = function()
            require('telescope-config')
        end,
    }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
    use {
        'ThePrimeagen/harpoon',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        },
        config = function()
            require('harpoon-config')
        end,
    }
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use { 'neovim/nvim-lspconfig', config = "require('lsp')" }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }
    -- use { 'hrsh7th/cmp-vsnip' }
    use { 'sindrets/diffview.nvim' }
    use { 'kdheepak/lazygit.nvim', config = "require('lazygit-config')" }
    use {
        'TimUntersberger/neogit',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'sindrets/diffview.nvim' }
        },
        config = "require('neogit-config')"
    }
    use {
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = "require('rest-nvim-config')"
    }
    use { 'folke/todo-comments.nvim', config = "require('todo-config')" }
    use { 'numToStr/Comment.nvim', config = "require('comment-config')" }
    -- use { 'hrsh7th/vim-vsnip' }
    use { 'rafamadriz/friendly-snippets' }
    use { 'sheerun/vim-polyglot' }
    use { 'onsails/lspkind-nvim' }
    use { 'norcalli/nvim-colorizer.lua', config = "require('colorizer-config')", event = "BufRead" }
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup { current_line_blame = true }
        end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = "require('blankline-config')",
        event = "BufRead"
    }
    use { "akinsho/toggleterm.nvim", config = "require('toggleterm-config')" }
    use { 'tami5/lspsaga.nvim', config = "require('lspsaga-config')" }
    use { 'williamboman/nvim-lsp-installer' }
    use { 'jose-elias-alvarez/null-ls.nvim', config = "require('null-ls-config')" }
    use { "jose-elias-alvarez/nvim-lsp-ts-utils" }
    use { "folke/zen-mode.nvim", config = "require('zen-mode-config')" }
    use { "folke/twilight.nvim", config = "require('twilight-config')", after = "nvim-treesitter" }
    use { 'machakann/vim-highlightedyank', config = "vim.cmd('highlight Normal guibg=none')" }
    use { 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically

    -- JavaScript
    --use { 'posva/vim-vue', config = "require('vue-config')" }
    use { 'othree/javascript-libraries-syntax.vim' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
-- stylua: ignore end