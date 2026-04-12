-- =========================================================
-- Plugin: Treesitter Configuration
-- =========================================================
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        priority = 1000,

        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" }, -- ook main branch!
        },
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "bash", "html", "css", "scss", "javascript", "typescript",
                    "vue", "lua", "luadoc", "php", "go", "rust",
                    "dockerfile", "yaml", "toml", "json", "vim", "vimdoc",
                },

                auto_install = true,

                highlight = { enable = true },
                indent = { enable = true },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ia"] = "@parameter.inner",
                            ["aa"] = "@parameter.outer",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ["<leader>a"] = "@parameter.inner" },
                        swap_previous = { ["<leader>A"] = "@parameter.inner" },
                    },
                },
            })
        end,
    },

    -- 1. Context Commentstring
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        opts = { enable_autocmd = false },
        config = function(_, opts)
            vim.g.skip_ts_context_commentstring_module = true
            require('ts_context_commentstring').setup(opts)
        end
    },

    -- 2. Autotag
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {},
    },

    -- 3. Context (Sticky Headers)
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        opts = { mode = "cursor", max_lines = 3 }
    }
}
