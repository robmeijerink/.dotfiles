-- =========================================================
-- Plugin: Rest.nvim (Rob Meijerink)
-- =========================================================
return {
    "rest-nvim/rest.nvim",
    tag = "v2.0.1",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("rest-nvim").setup({
            result_split_horizontal = false,
            result_split_stay_in_current_window = true,
            skip_ssl_verification = false,
            encode_url = true,
            highlight = {
                enabled = true,
                timeout = 150,
            },
        })

        vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim", { desc = "Run HTTP Request" })
    end,
}