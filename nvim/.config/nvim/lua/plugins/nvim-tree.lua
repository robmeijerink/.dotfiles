-- =========================================================
-- Plugin: Nvim-Tree (Rob Meijerink)
-- =========================================================
return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>ew", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" },
    },
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            sync_root_with_cwd = true,
            view = {
                adaptive_size = true,
                number = true,
                relativenumber = true,
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        folder_arrow = false, -- Clean UI without arrows
                    },
                },
                indent_markers = {
                    enable = true,
                },
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
                ignore = false,
                timeout = 400,
            },
            filesystem_watchers = {
                ignore_dirs = {
                    "node_modules",
                    "vendor",
                },
            },
        })
    end,
}
