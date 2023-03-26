-- Lazy.nvim Installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy requires the leader key to be mapped first.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- stylua: ignore start
require('lazy').setup({
    -- Colorscheme section
    -- use { "ellisonleao/gruvbox.nvim" }
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     build = ":CatppuccinCompile",
    -- },
    'Mofiqul/dracula.nvim',
    -- use("folke/tokyonight.nvim")
    -- use { "tanvirtin/monokai.nvim" }
    -- Plugins
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = "BufWinEnter",
        config = function()
            require('robmeijerink.treesitter')
        end,
        -- commit = "c32abac525257723879f1cfe5cc59528105d29c6"
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
            'nvim-treesitter/nvim-treesitter-context',     -- Sticky header for functions
            { 'windwp/nvim-ts-autotag', event = "InsertEnter" },
            'p00f/nvim-ts-rainbow',
            {
                "folke/twilight.nvim",
                cmd = 'Twilight',
                config = function()
                    require('robmeijerink.twilight')
                end,
            },
        },
    },

    -- Easier installing of LSP, DAP, Linters, Formatters etc.
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Diagnostics and Formatting
            { 'jose-elias-alvarez/null-ls.nvim' },

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                event = { "InsertEnter", "CmdlineEnter" },
                dependencies = {
                    -- Snippets
                    {'L3MON4D3/LuaSnip'},
                    {'rafamadriz/friendly-snippets'},
                    { 'tzachar/cmp-tabnine', build = './install.sh' },
                    {
                        'windwp/nvim-autopairs',
                        config = function()
                            require('robmeijerink.autopairs')
                        end,
                    },
                    {'hrsh7th/cmp-buffer'},
                    {'hrsh7th/cmp-path'},
                    {'saadparwaiz1/cmp_luasnip'},
                    {'hrsh7th/cmp-nvim-lsp'},
                    {'hrsh7th/cmp-nvim-lua'},
                },
            },

            -- OTHERS
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('robmeijerink.lualine')
        end,
        dependencies = { 'kyazdani42/nvim-web-devicons' }
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        event = "BufWinEnter",
        config = function()
            require('robmeijerink.bufferline')
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        cmd = { 'NvimTreeToggle' },
        config = function()
            require('robmeijerink.nvim-tree')
        end,
    },
    -- {
    --     "lewis6991/impatient.nvim",
    --     config = function()
    --         require('robmeijerink.impatient')
    --     end,
    -- },
    "moll/vim-bbye",
    { 'mbbill/undotree', cmd = 'UndotreeToggle' },

    'folke/which-key.nvim',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' }, { "kdheepak/lazygit.nvim" }, { "kyazdani42/nvim-web-devicons" } },
        -- cmd = "Telescope",
        config = function()
            require('robmeijerink.telescope')
        end,
    },
    -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable "make" == 1, dependencies = 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim', dependencies = 'nvim-telescope/telescope.nvim' },
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            { 'nvim-lua/plenary.nvim' }
        },
        config = function()
            require('robmeijerink.harpoon')
        end,
    },
    -- use({
    --     "kylechui/nvim-surround",
    --     config = function()
    --         require("nvim-surround").setup({
    --             -- Configuration here, or leave empty to use defaults
    --         })
    --     end
    -- })
    "tpope/vim-surround",
    -- {
    --     'sindrets/diffview.nvim',
    --     dependencies = { "kyazdani42/nvim-web-devicons" },
    --     -- cmd = { 'DiffviewOpen', 'DiffviewFileHistory' }
    -- },
    {
        'kdheepak/lazygit.nvim',
        cmd = {
            'LazyGit',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        config = function()
            require('robmeijerink.lazygit')
        end,
    },
    -- use {
    --     'TimUntersberger/neogit',
    --     cmd = 'Neogit',
    --     dependencies = {
    --         { 'nvim-lua/plenary.nvim' },
    --         { 'sindrets/diffview.nvim' }
    --     },
    --     config = "require('robmeijerink.neogit')"
    -- }
    "tpope/vim-fugitive",
    {
        "NTBBloodbath/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('robmeijerink.rest-nvim')
        end,
        cmd = { 'RestNvim', 'RestNvimPreview', 'RestNvimLast' }
    },
    {
        'folke/todo-comments.nvim',
        config = function()
            require('robmeijerink.todo')
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('robmeijerink.comment')
        end,
    },
    -- use { 'hrsh7th/vim-vsnip' }
    { 'sheerun/vim-polyglot' },
    'onsails/lspkind-nvim',
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('robmeijerink.colorizer')
        end,
        event = "BufRead"
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup { current_line_blame = true }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require('robmeijerink.blankline')
        end,
        event = "BufRead"
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            { "kyazdani42/nvim-web-devicons" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require('robmeijerink.trouble')
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require('robmeijerink.toggleterm')
        end,
    },
    {
        'tami5/lspsaga.nvim',
        cmd = 'Lspsaga',
        config = function()
            require('robmeijerink.lspsaga')
        end,
    },
    {
        "folke/zen-mode.nvim",
        cmd = 'ZenMode',
        config = function()
            require('robmeijerink.zen-mode')
        end,
    },
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-repeat', -- Better repeat with plugin keymaps.

    -- JavaScript
    --use { 'posva/vim-vue', config = "require('robmeijerink.vue')" }
    'othree/javascript-libraries-syntax.vim',

    -- Debugger
    -- use { 'mfussenegger/nvim-dap' }
    -- use { 'rcarriga/nvim-dap-ui' }
    -- use { 'theHamsta/nvim-dap-virtual-text' }
    -- use { 'nvim-telescope/telescope-dap.nvim' }

    -- Testing
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- "antoinemadec/FixCursorHold.nvim",
            'olimorris/neotest-phpunit',
        },
        config = function()
            require('robmeijerink.neotest')
        end,
    },

    -- Enable dd in quickfix list
    'TamaMcGlinn/quickfixdd',

    -- Better Search & Replace
    'windwp/nvim-spectre',

    -- Docblock generator
    {
        "danymat/neogen",
        cmd = "Neogen",
        config = function()
            require('neogen').setup({
                snippet_engine = "luasnip"
            })
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
    },

    -- Better split and join blocks of code.
    {
        'Wansmer/treesj',
        cmd = "TSJToggle",
        dependencies = { 'nvim-treesitter' },
        config = function()
            require('robmeijerink.treesj')
        end,
    },

    -- Better LSP signature with parameter hints.
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require('robmeijerink.lsp-signature')
        end,
    },

    -- Simple image viewer: cmd :ViewImage
    {
      "princejoogie/chafa.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "m00qek/baleia.nvim"
      },
      config = function()
          require('robmeijerink.chafa')
      end,
    },

    {
        "roobert/search-replace.nvim",
        config = function()
            require("search-replace").setup({
              -- optionally override defaults
              -- default_replace_single_buffer_options = "gcI",
              -- default_replace_multi_buffer_options = "egcI",
            })
        end,
    },
})
-- stylua: ignore end
