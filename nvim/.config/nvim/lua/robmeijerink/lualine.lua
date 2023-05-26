-- local char_count = function()
--     if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
--         return string.format("%sC", vim.fn.wordcount().visual_chars)
--     else
--         return string.format("%sC", vim.fn.wordcount().chars)
--     end
-- end
--
-- local word_count = function()
--     if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
--         return string.format("%sW", vim.fn.wordcount().visual_words)
--     else
--         return string.format("%sW", vim.fn.wordcount().words)
--     end
-- end

require("lualine").setup({
    options = {
        icons_enabled = true,
        -- theme = 'auto',
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
        globalstatus = true,
        theme = {
          normal = {
            a = 'StatusLine',
            b = 'StatusLine',
            c = 'StatusLine',
        },
    },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diff",
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
            },
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = "󰌶 ",
                },
            }
        },
        lualine_c = {
            {
                "filetype",
                icon_only = true,
                padding = {
                    left = 1,
                    right = 0,
                },
                separator = {
                    right = "",
                },
            },
            "filename",
        },
        lualine_x = { 'encoding', 'fileformat', '(vim.bo.expandtab and "·" or "⇥") .. " " .. vim.bo.shiftwidth' },
        lualine_y = { "location" },
        lualine_z = { "progress" },
    },
    extensions = {
        "nvim-tree",
    }
})

-- require('lualine').setup {
--     options = {
--       icons_enabled = true,
--       theme = 'auto',
--       component_separators = { left = '', right = ''},
--       section_separators = { left = '', right = ''},
--       disabled_filetypes = {},
--       always_divide_middle = true,
--       globalstatus = false,
--     },
--     sections = {
--       lualine_a = {'mode'},
--       lualine_b = {'branch', 'diff', 'diagnostics'},
--       lualine_c = {'filename'},
--       lualine_x = {'encoding', 'fileformat', 'filetype'},
--       lualine_y = {'progress'},
--       lualine_z = {'location'}
--     },
--     inactive_sections = {
--       lualine_a = {},
--       lualine_b = {},
--       lualine_c = {'filename'},
--       lualine_x = {'location'},
--       lualine_y = {},
--       lualine_z = {}
--     },
--     tabline = {},
--     extensions = {}
-- }
