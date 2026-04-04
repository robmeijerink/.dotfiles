-- =========================================================
-- Plugin: UI Addons (Rob Meijerink)
-- =========================================================
return {
    -- 1. Indent Blankline (Visual indent guides)
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        opts = {
            exclude = {
                buftypes = { "terminal" },
                filetypes = { "dashboard", "NvimTree", "packer", "lsp-installer" },
            },
        },
    },

    {
        "NvChad/nvim-colorizer.lua",
        -- Explicitly set the name to avoid collisions with the old dir
        name = "nvim-colorizer",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    -- Performance: disable names to avoid O(L*W) string lookups
                    names = false,
                    RRGGBBAA = true,
                    rgb_fn = true,
                    hsl_fn = true,
                    css = true,
                    mode = "background",
                },
            })
        end,
    },

    -- 3. Illuminate (Highlight same words)
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        config = function()
            require("illuminate").configure({
                providers = { 'lsp', 'treesitter', 'regex' },
            })
        end,
    }
}
