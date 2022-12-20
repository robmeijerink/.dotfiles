-- vim.g.rob_colorscheme = "tokyonight"
-- vim.g.rob_colorscheme = "gruvbox"
vim.g.rob_colorscheme = "catppuccin"

function ColorMyPencils()
    -- require("gruvbox").setup({
    --     italic = false,
    --     contrast = "hard",
    --     invert_selection = false,
    -- })

    -- local monokai = require('monokai')
    -- monokai.setup({
    --     palette = monokai.pro,
    --     italics = false,
    -- })

    vim.g.catppuccin_flavour = "mocha"

    require("catppuccin").setup({
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
            -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
        },
        color_overrides = {},
        highlight_overrides = {},
    })

    -- vim.g.tokyonight_style = "night"
    -- vim.g.tokyonight_transparent_sidebar = true
    -- vim.g.tokyonight_italic_variables = false
    -- vim.g.tokyonight_italic_keywords = false
    -- vim.g.tokyonight_transparent = true
    -- vim.g.gruvbox_contrast_dark = 'hard'
    -- vim.g.gruvbox_invert_selection = '0'
    vim.opt.background = "dark"

    vim.cmd("colorscheme " .. vim.g.rob_colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", {
        bg = "none",
    })

    hl("ColorColumn", {
        ctermbg = 0,
        bg = "#555555",
    })

    hl("CursorLineNR", {
        bg = "None"
    })

    hl("Normal", {
        bg = "none"
    })

    hl("LineNr", {
        fg = "#5eacd3"
    })

    hl("netrwDir", {
        fg = "#5eacd3"
    })

    hl("WinSeperator", {
        bg = "None",
    })

end

ColorMyPencils()
