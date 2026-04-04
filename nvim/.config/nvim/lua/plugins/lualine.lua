-- =========================================================
-- Plugin: lualine.nvim
-- Focus: Unified B2B Statusline & Navic Breadcrumbs
-- =========================================================
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic", -- Used for Breadcrumbs
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = {
                    normal = {
                        a = { bg = "#61afef", fg = "#282a36", gui = "bold" },
                        b = "StatusLine",
                        c = "StatusLine",
                    },
                    insert = {
                        a = { bg = "#e06c75", fg = "#282a36", gui = "bold" },
                        b = "StatusLine",
                        c = "StatusLine",
                    },
                    visual = {
                        a = { bg = "#c678dd", fg = "#282a36", gui = "bold" },
                        b = "StatusLine",
                        c = "StatusLine",
                    },
                    command = {
                        a = { bg = "#e5c07b", fg = "#282a36", gui = "bold" },
                        b = "StatusLine",
                        c = "StatusLine",
                    },
                    replace = {
                        a = { bg = "#ff5c00", fg = "#282a36", gui = "bold" },
                        b = "StatusLine",
                        c = "StatusLine",
                    },
                    inactive = {
                        a = "StatusLine",
                        b = "StatusLine",
                        c = "StatusLine",
                    },
                },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },

            -- =============================================
            -- Breadcrumbs (Direct API call to omit filename)
            -- =============================================
            winbar = {
                lualine_a = {
                    {
                        function()
                            local navic = require("nvim-navic")
                            if navic.is_available() then
                                return navic.get_location()
                            end
                            return ""
                        end,
                        padding = { left = 6, right = 1 },
                    },
                },
            },

            -- =============================================
            -- Statusline Bottom
            -- =============================================
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        symbols = { added = " ", modified = " ", removed = " " },
                    },
                    {
                        "diagnostics",
                        symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
                    },
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
                    "encoding",
                    "fileformat",
                    function()
                        return (vim.bo.expandtab and "·" or "⇥") .. " " .. vim.bo.shiftwidth
                    end,
                },
                lualine_y = { "location" },
                lualine_z = { "progress" },
            },

            extensions = {
                -- "nvim-tree", Not needed for now.
            },
        })
    end,
}
