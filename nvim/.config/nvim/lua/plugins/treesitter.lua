-- =========================================================
-- Plugin: Treesitter (Rob Meijerink)
-- =========================================================
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            -- Set up context commentstring first
            require('ts_context_commentstring').setup({})
            vim.g.skip_ts_context_commentstring_module = true

            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "bash", "html", "css", "scss", "javascript", "typescript",
                    "vue", "lua", "luadoc", "php", "go", "gomod", "rust",
                    "dockerfile", "yaml", "toml", "http", "json", "diff",
                    "vim", "vimdoc",
                },
                sync_installed = true,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = { 'NvimTree' },
                },

                indent = { enable = true },

                autotag = { enable = true },

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
    -- Context (Sticky Headers)
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        opts = { mode = "cursor", max_lines = 3 }
    }
}
