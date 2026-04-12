-- =========================================================
-- Plugin: Oil.nvim (File Explorer as a Text Buffer)
-- =========================================================
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open Parent Directory (Oil)" },
        -- { "<leader>ee", "<cmd>Oil --float<CR>", desc = "Toggle Oil Floating" },
    },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,

            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".." or name == ".git"
                end,
            },

            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-p>"] = "actions.preview",
                ["q"] = "actions.close",
                ["-"] = "actions.parent",
            },

            float = {
                padding = 2,
                max_width = 100,
                max_height = 0.8,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
            },
        })
    end,
}
