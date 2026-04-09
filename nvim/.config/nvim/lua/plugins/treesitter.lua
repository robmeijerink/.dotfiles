-- =========================================================
-- Plugin: Treesitter Configuration
-- =========================================================
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            -- Prevent fatal crashes if the plugin is not yet installed
            local status_ok, configs = pcall(require, "nvim-treesitter.configs")
            if not status_ok then
                return
            end

            configs.setup({
                ensure_installed = {
                    "bash", "html", "css", "scss", "javascript", "typescript",
                    "vue", "lua", "luadoc", "php", "go", "gomod", "rust",
                    "dockerfile", "yaml", "toml", "http", "json", "diff",
                    "vim", "vimdoc",
                },
                sync_installed = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = { 'NvimTree', 'bash' },
                },

                indent = {
                    enable = true,
                    disable = { 'bash' }
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },

                textobjects = {
                    select = {
                        enable = true,
                        disable = { "bash" },
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['ia'] = '@parameter.inner',
                            ['aa'] = '@parameter.outer',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
                        goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
                        goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
                        goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ['<leader>a'] = '@parameter.inner' },
                        swap_previous = { ['<leader>A'] = '@parameter.inner' },
                    },
                },
            })
        end,
    },

    -- =========================================================
    -- Standalone Plugins (Decoupled for parallel loading)
    -- =========================================================

    -- Context Commentstring
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require('ts_context_commentstring').setup({})
        end
    },

    -- Autotag
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },

    -- Context (Sticky Headers)
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        opts = { mode = "cursor", max_lines = 3 }
    }
}
