-- =========================================================
-- Plugin: Zen mode (Dim distractions)
-- =========================================================
return {
    "folke/zen-mode.nvim",
    keys = {
        { "<leader>zz", function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
    },
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
}
