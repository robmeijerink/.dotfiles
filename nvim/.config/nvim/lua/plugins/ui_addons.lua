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

    -- 2. Colorizer (Hex color previews)
    {
        'norcalli/nvim-colorizer.lua',
        event = "BufRead",
        config = function()
            require("colorizer").setup({
                filetypes = {
                    "*",
                    css = { rgb_fn = true },
                    html = { names = false },
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
