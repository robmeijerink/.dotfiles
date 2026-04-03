-- =========================================================
-- Plugin: Lualine (Rob Meijerink Architecture)
-- =========================================================
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
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
                        padding = { left = 1, right = 0 },
                        separator = { right = "" },
                    },
                    "filename",
                },
                lualine_x = {
                    'encoding',
                    'fileformat',
                    -- Custom logic for indent display from your config
                    function()
                        local space = vim.bo.expandtab and "·" or "⇥"
                        return space .. " " .. vim.bo.shiftwidth
                    end
                },
                lualine_y = { "location" },
                lualine_z = { "progress" },
            },
            extensions = { "nvim-tree" }
        })
    end
}
