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
    {
        'Mofiqul/dracula.nvim',
        -- commit = '26d04c8ced02f02207e7aec1d5730c3a9ebadeeb'
    },
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
            'JoosepAlviste/nvim-ts-context-commentstring', -- Solves comment issue in multi lang files
            { 'windwp/nvim-ts-autotag', event = "InsertEnter" },
            -- 'p00f/nvim-ts-rainbow', // No longer Maintained
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
            -- { 'jose-elias-alvarez/null-ls.nvim' }, // Archived / Deprecated
            --
            -- @todo: Replacements
            -- { 'mhartington/formatter.nvim' },
            -- { 'mfussenegger/nvim-lint' },

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                event = { "InsertEnter", "CmdlineEnter" },
                dependencies = {
                    -- Snippets
                    {'L3MON4D3/LuaSnip'},
                    {'rafamadriz/friendly-snippets'},
                    {
                        "zbirenbaum/copilot.lua",
                        config = function()
                            require("copilot").setup({
                              suggestion = { enabled = false },
                              panel = { enabled = false },
                            })
                        end,
                    },
                    {
                      "zbirenbaum/copilot-cmp",
                      config = function ()
                        require("copilot_cmp").setup()
                      end
                    },
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
                    {'hrsh7th/cmp-nvim-lsp-signature-help'},
                    {'hrsh7th/cmp-nvim-lua'},
                    {'onsails/lspkind.nvim'},
                    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
                },
            },

            -- OTHERS
            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', tag = "v1.0.0", event = "LspAttach" },

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
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
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
    {
        'vuki656/package-info.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim'
        },
        config = function()
            require('package-info').setup()
        end,
    },
    "moll/vim-bbye",
    { 'mbbill/undotree', cmd = 'UndotreeToggle' },

    -- 'folke/which-key.nvim',
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
            require("harpoon").setup({})
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"},
        },
    },
    -- use({
    --     "kylechui/nvim-surround",
    --     config = function()
    --         require("nvim-surround").setup({
    --             -- Configuration here, or leave empty to use defaults
    --         })
    --     end
    -- })
    'tpope/vim-eunuch', -- Adds :Rename, :SudoWrite
    "tpope/vim-surround",
    {
        'sindrets/diffview.nvim',
        dependencies = { "kyazdani42/nvim-web-devicons" },
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' }
    },
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
    {
        "tpope/vim-fugitive",
        cmd = {
            'Git',
            'G'
        },
        dependencies = {
            'tpope/vim-rhubarb',
        },
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        opts = {
            rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
        }
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = { "luarocks.nvim" },
        config = function()
            require('robmeijerink.rest-nvim')
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('robmeijerink.comment')
        end,
    },
    { 'sheerun/vim-polyglot' },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({})
        end,
        event = "BufRead"
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
                sign_priority = 20,
                on_attach = function(bufnr)
                    vim.keymap.set('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, buffer = bufnr })
                    vim.keymap.set('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, buffer = bufnr })
                end,
            }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
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
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
            }
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require('robmeijerink.toggleterm')
        end,
    },
    -- {
    --     'tami5/lspsaga.nvim',
    --     cmd = 'Lspsaga',
    --     config = function()
    --         require('robmeijerink.lspsaga')
    --     end,
    -- },
    {
        "folke/zen-mode.nvim",
        cmd = 'ZenMode',
        config = function()
            require('robmeijerink.zen-mode')
        end,
    },
    'tpope/vim-unimpaired', -- Adds [b and other handy mappings
    { 'tpope/vim-sleuth', lazy = true }, -- Detect tabstop and shiftwidth automatically
    'tpope/vim-repeat', -- Better repeat with plugin keymaps.

    'christoomey/vim-tmux-navigator', -- Use splits in vim as if tmux splits when navigating

    'nelstrom/vim-visual-star-search', -- use * in visual mode too

    -- JavaScript
    --use { 'posva/vim-vue', config = "require('robmeijerink.vue')" }
    'othree/javascript-libraries-syntax.vim',

    'jessarcher/vim-heritage', -- Automatically create parent dirs when saving

    -- Text objects for HTML attributes.
    {
      'whatyouhide/vim-textobj-xmlattr',
      dependencies = { 'kana/vim-textobj-user' },
    },

    {
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup()
        require('neoscroll.config').set_mappings({
          ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '50' } },
          ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '50' } },
        })
      end,
    },

    {
      'AndrewRadev/splitjoin.vim',
      config = function()
        vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_php_method_chain_full = 1
      end,
    },

    {
      'sickill/vim-pasta',
      config = function()
        vim.g.pasta_disabled_filetypes = { 'fugitive' }
      end,
    },

    -- Debugger
    { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui' },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'nvim-telescope/telescope-dap.nvim' },

    -- Testing
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            'theutz/neotest-pest'
        },
        config = function()
            require('robmeijerink.neotest')
        end,
    },

    -- Error: [lsp-zero] Some language servers have been configured before lsp-zero could finish its initial setup. Some features may fail.
    -- {
    --     "gbprod/phpactor.nvim",
    --     build = function()
    --         require("phpactor.handler.update")()
    --     end,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "neovim/nvim-lspconfig"
    --     },
    --     opts = {
    --         -- you're options coes here
    --     },
    -- },

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
    -- Highlight all words under cursor
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
            })
        end,
    },
})
-- stylua: ignore end
