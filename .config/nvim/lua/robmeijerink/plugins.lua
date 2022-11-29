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

-- Performance
pcall(require, "impatient")

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
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        run = ":CatppuccinCompile"
    }
    -- use("folke/tokyonight.nvim")
    -- use { "tanvirtin/monokai.nvim" }
    -- Plugins
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        event = "BufWinEnter",
        config = "require('robmeijerink.treesitter')",
        -- commit = "c32abac525257723879f1cfe5cc59528105d29c6"
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = "nvim-treesitter" } -- Additional textobjects for treesitter
    use { 'nvim-treesitter/nvim-treesitter-context', after = "nvim-treesitter" } -- Sticky header for functions
    use {
        'nvim-lualine/lualine.nvim',
        config = "require('robmeijerink.lualine')",
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        event = "BufWinEnter",
        config = "require('robmeijerink.bufferline')"
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        cmd = { 'NvimTreeToggle' },
        config = "require('robmeijerink.nvim-tree')"
    }
    use { "lewis6991/impatient.nvim", config = "require('robmeijerink.impatient')" }
    use { "moll/vim-bbye" }
    use { 'mbbill/undotree', cmd = 'UndotreeToggle' }
    use { 'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter" }
    use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
    use { 'windwp/nvim-autopairs', config = "require('robmeijerink.autopairs')", after = "nvim-cmp" }
    use { 'folke/which-key.nvim' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' }, { "kdheepak/lazygit.nvim" }, { "kyazdani42/nvim-web-devicons" } },
        -- cmd = "Telescope",
        config = function()
            require('robmeijerink.telescope')
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
            require('robmeijerink.harpoon')
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
    use { 'neovim/nvim-lspconfig', config = "require('robmeijerink.lsp')" }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }
    -- use { 'hrsh7th/cmp-vsnip' }
    use {
        'sindrets/diffview.nvim',
        requires = { "kyazdani42/nvim-web-devicons" },
        -- cmd = { 'DiffviewOpen', 'DiffviewFileHistory' }
    }
    use {
        'kdheepak/lazygit.nvim',
        cmd = {
            'LazyGit',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        config = "require('robmeijerink.lazygit')"
    }
    use {
        'TimUntersberger/neogit',
        cmd = 'Neogit',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'sindrets/diffview.nvim' }
        },
        config = "require('robmeijerink.neogit')"
    }
    use {
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = "require('robmeijerink.rest-nvim')",
        cmd = { 'RestNvim', 'RestNvimPreview', 'RestNvimLast' }
    }
    use { 'folke/todo-comments.nvim', config = "require('robmeijerink.todo')" }
    use { 'numToStr/Comment.nvim', config = "require('robmeijerink.comment')" }
    -- use { 'hrsh7th/vim-vsnip' }
    use { 'rafamadriz/friendly-snippets' }
    use { 'sheerun/vim-polyglot' }
    use { 'onsails/lspkind-nvim' }
    use { 'norcalli/nvim-colorizer.lua', config = "require('robmeijerink.colorizer')", event = "BufRead" }
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup { current_line_blame = true }
        end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = "require('robmeijerink.blankline')",
        event = "BufRead"
    }
    use {
        "folke/trouble.nvim",
        requires = {
            { "kyazdani42/nvim-web-devicons" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = "require('robmeijerink.trouble')"
    }
    use { "akinsho/toggleterm.nvim", config = "require('robmeijerink.toggleterm')" }
    use { 'tami5/lspsaga.nvim', cmd = 'Lspsaga', config = "require('robmeijerink.lspsaga')" }
    use { 'williamboman/nvim-lsp-installer' }
    use { 'jose-elias-alvarez/null-ls.nvim', config = "require('robmeijerink.null-ls')" }
    use { "jose-elias-alvarez/nvim-lsp-ts-utils" }
    use { "folke/zen-mode.nvim", cmd = 'ZenMode', config = "require('robmeijerink.zen-mode')" }
    use { "folke/twilight.nvim", cmd = 'Twilight', config = "require('robmeijerink.twilight')", after = "nvim-treesitter" }
    use { 'machakann/vim-highlightedyank', config = "vim.cmd('highlight Normal guibg=none')" }
    use { 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically

    -- JavaScript
    --use { 'posva/vim-vue', config = "require('robmeijerink.vue')" }
    use { 'othree/javascript-libraries-syntax.vim' }

    -- Easier installing of LSP, DAP, Linters, Formatters etc.
    use { "williamboman/mason.nvim", config = "require('robmeijerink.mason')" }
    use {
        "williamboman/mason-lspconfig.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
    }

    -- Debugger
    use { 'mfussenegger/nvim-dap' }
    use { 'rcarriga/nvim-dap-ui' }
    use { 'theHamsta/nvim-dap-virtual-text' }
    use { 'nvim-telescope/telescope-dap.nvim' }

    -- Testing
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'olimorris/neotest-phpunit',
        },
        config = "require('robmeijerink.neotest')"
    }

    -- Enable dd in quickfix list
    use { 'TamaMcGlinn/quickfixdd' }

    -- Better Search & Replace
    use { 'windwp/nvim-spectre' }

    -- Docblock generator
    use {
        "danymat/neogen",
        cmd = "Neogen",
        config = function()
            require('neogen').setup({
                snippet_engine = "luasnip"
            })
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        tag = "*"
    }

    -- Better split and join blocks of code.
    use({
        'Wansmer/treesj',
        cmd = "TSJToggle",
        requires = { 'nvim-treesitter' },
        config = "require('robmeijerink.treesj')",
    })

    -- Tabnine
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
-- stylua: ignore end
