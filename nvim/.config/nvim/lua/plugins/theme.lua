-- =========================================================
-- Plugin: Theme Manager (Rob Meijerink Architecture)
-- =========================================================
return {
    -- 1. Dracula (Currently Active)
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            local dracula = require("dracula")

            dracula.setup({
                colors = {
                    bg = "none",
                },
                transparent_bg = true,
                show_end_of_buffer = true,
            })

            vim.opt.background = "dark"
            vim.cmd.colorscheme("dracula")

            -- Custom Highlight Overrides (Rob Meijerink Baseline)
            local hl = vim.api.nvim_set_hl
            hl(0, "SignColumn", { bg = "none" })
            hl(0, "ColorColumn", { ctermbg = 0, bg = "#555555" })
            hl(0, "CursorLine", { bg = "#0F0F0F" })
            hl(0, "CursorLineNr", { bg = "none" })
            hl(0, "Normal", { bg = "none" })
            hl(0, "LineNr", { fg = "#5eacd3" })
            hl(0, "netrwDir", { fg = "#5eacd3" })
            hl(0, "WinSeparator", { bg = "none" })

            -- DiffView readability
            hl(0, "DiffAdd", { bg = "#375c41" })
            hl(0, "diffAdded", { bg = "#375c41" })
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

            -- Apply same highlight overrides for consistency if needed
            local hl = vim.api.nvim_set_hl
            hl(0, "Normal", { bg = "none" })
            hl(0, "SignColumn", { bg = "none" })
        end
    },
}
