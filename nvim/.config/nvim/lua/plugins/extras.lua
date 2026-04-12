-- =========================================================
-- Plugin: Extra Features
-- =========================================================
return {
    -- 1. Trouble (Diagnostic list)
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        keys = {
            { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        }
    },

    -- 2. Chafa (Image viewer)
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
