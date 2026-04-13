-- =========================================================
-- Plugin: Theme Manager (Rob Meijerink)
-- =========================================================
return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local dracula = require("dracula")

            dracula.setup({
                colors = { bg = "none" },
                transparent_bg = true,
                show_end_of_buffer = true,
            })

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "dracula",
                callback = function()
                    local hl = vim.api.nvim_set_hl
                    local bar_bg = "#111111"

                    hl(0, "Normal", { bg = "none", fg = "#bcbcbc" })
                    hl(0, "EndOfBuffer", { fg = "#3b4252" })
                    hl(0, "StatusLine", { bg = bar_bg, fg = "#f8f8f2" })
                    hl(0, "StatusLineNC", { bg = "#0a0a0a", fg = "#6272a4" })
                    hl(0, "TabLineFill", { bg = "none" })
                    hl(0, "SignColumn", { bg = "none" })
                    hl(0, "ColorColumn", { ctermbg = 0, bg = "#333333" })
                    hl(0, "CursorLine", { bg = "#0F0F0F" })
                    hl(0, "CursorLineNr", { bg = "none", fg = "#bcbcbc" })
                    hl(0, "LineNr", { fg = "#44475a" })
                    hl(0, "WinSeparator", { bg = "none", fg = bar_bg })
                    hl(0, "DiffAdd", { bg = "#375c41" })
                    hl(0, "diffAdded", { bg = "#375c41" })

                    -- Core theme colors ===
                    local white = "#ffffff"
                    local dracula_pink = "#ff79c6"
                    local dracula_green = "#50fa7b"
                    -- local dracula_purple = "#bd93f9"
                    local dracula_orange = "#ffb86c"
                    -- local dracula_cyan = "#8be9fd"

                    -- General Fixes
                    hl(0, "@keyword.function", { fg = dracula_pink, bold = false })
                    hl(0, "@variable.parameter", { fg = white, bold = false })
                    hl(0, "@markup.heading", { fg = dracula_orange, bold = false })
                    hl(0, "@markup.strong", { fg = white, bold = false })
                    hl(0, "@markup.link", { fg = white, bold = false })

                    -- Blade Fixes
                    hl(0, "@tag.delimiter.blade", { fg = white, bold = false })
                    hl(0, "@tag.blade", { fg = dracula_pink, bold = false })
                    hl(0, "@tag.attribute.blade", { fg = dracula_green, italic = false })

                    -- HTML Fixes
                    hl(0, "@tag.delimiter.html", { fg = white, bold = false })
                    hl(0, "@tag.builtin.html", { fg = dracula_pink, bold = false })
                    hl(0, "@tag.html", { fg = dracula_pink, bold = false })
                    hl(0, "@tag.attribute.html", { fg = dracula_green, italic = false })
                end,
            })

            vim.opt.background = "dark"
            vim.cmd.colorscheme("dracula")
        end
    },

    -- 2. Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        enabled = false, -- <--- INACTIVE (Zero overhead)
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                term_colors = false,
                compile = {
                    enabled = true,
                    path = vim.fn.stdpath("cache") .. "/catppuccin",
                },
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.25,
                },
                styles = {
                    comments = {},
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                integrations = {
                    cmp = true,
                    dap = true,
                    gitsigns = true,
                    harpoon = true,
                    lsp_saga = true,
                    lsp_trouble = true,
                    neogit = true,
                    neotest = true,
                    mason = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                    ts_rainbow = true,
                    which_key = true,
                },
            })

            vim.opt.background = "dark"
            vim.cmd.colorscheme("catppuccin")

            -- Custom Highlight Overrides
            local hl = vim.api.nvim_set_hl
            local bar_bg = "#111111"

            -- O(1) Color Overrides
            hl(0, "Normal", { bg = "none", fg = "#bcbcbc" })
            hl(0, "EndOfBuffer", { fg = "#3b4252" })

            -- UI Elements
            hl(0, "StatusLine", { bg = bar_bg, fg = "#f8f8f2" })
            hl(0, "StatusLineNC", { bg = "#0a0a0a", fg = "#6272a4" })
            hl(0, "TabLineFill", { bg = "none" })

            -- Functional Overrides
            hl(0, "SignColumn", { bg = "none" })
            hl(0, "ColorColumn", { ctermbg = 0, bg = "#333333" })
            hl(0, "CursorLine", { bg = "#0F0F0F" })
            hl(0, "CursorLineNr", { bg = "none", fg = "#bcbcbc" })
            hl(0, "LineNr", { fg = "#44475a" })
            hl(0, "WinSeparator", { bg = "none", fg = bar_bg })

            -- DiffView readability
            hl(0, "DiffAdd", { bg = "#375c41" })
            hl(0, "diffAdded", { bg = "#375c41" })
        end
    },
}
