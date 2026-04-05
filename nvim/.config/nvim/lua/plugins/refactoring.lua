-- =========================================================
-- Plugin: Refactoring (Rob Meijerink)
-- =========================================================
return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>re", [[<cmd>lua require('refactoring').refactor('Extract Method')<cr>]], mode = "v", desc = "Extract Method" },
        { "<leader>rf", [[<cmd>lua require('refactoring').refactor('Extract Method To File')<cr>]], mode = "v", desc = "Extract Method To File" },
        { "<leader>rv", [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], mode = "v", desc = "Extract Variable" },
        { "<leader>ri", [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], mode = { "n", "v" }, desc = "Inline Variable" },
    },
    opts = {},
}
