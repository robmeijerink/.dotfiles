-- =========================================================
-- Plugin: Extra Features (Zen, Trouble, Neogen, Chafa)
-- =========================================================
return {
    -- 1. Zen Mode (Focus)
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            window = {
                backdrop = 0.95,
                width = 100,
                height = 0.8,
                options = { signcolumn = "no", number = false, cursorline = false }
            },
            plugins = {
                options = { enabled = true, ruler = false, showcmd = false },
                twilight = { enabled = true },
                gitsigns = { enabled = false },
                tmux = { enabled = false }
            }
        }
    },

    -- 2. Trouble (Diagnostic list)
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        keys = {
            { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        }
    },

    -- 3. Neogen (Docblock generator)
    {
        "danymat/neogen",
        cmd = "Neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = { snippet_engine = "luasnip" },
    },

    -- 4. Chafa (Image viewer)
    {
        "princejoogie/chafa.nvim",
        cmd = "ViewImage",
        dependencies = { "nvim-lua/plenary.nvim", "m00qek/baleia.nvim" },
        opts = {
            render = { min_padding = 5, show_label = true },
            events = { update_on_nvim_resize = true },
        }
    },
}
