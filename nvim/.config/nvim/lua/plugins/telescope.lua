-- =========================================================
-- Plugin: telescope.nvim
-- Focus: Fuzzy finding and project navigation
-- =========================================================
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- Ensure trouble is in the dependency tree if mappings rely on it
        "folke/trouble.nvim",
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>",                                                             desc = "Find Files" },
        { "<leader>fa", function() require('telescope.builtin').find_files({ no_ignore = true, hidden = true }) end, desc = "All Files" },
        { "<leader>fg", function() require('telescope').extensions.live_grep_args.live_grep_args() end,              desc = "Grep (Args)" },
        { "<leader>fw", "<cmd>Telescope grep_string<CR>",                                                            desc = "Grep Word" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>",                                                               desc = "Recent Files" },
        { "<leader>fr", "<cmd>Telescope resume<CR>",                                                                 desc = "Resume Search" },
        { "<leader>fx", "<cmd>Telescope buffers show_all_buffers=true<CR>",                                          desc = "Telescope Buffers" },
        -- SECURITY/PERF REMOVAL: <leader>ft (tmux-sessionizer) must be moved to keymaps.lua
    },
    config = function()
        local actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        -- 1. Safe require for Trouble to prevent silent plugin crashes
        local has_trouble, trouble = pcall(require, "trouble.sources.telescope")

        local custom_mappings = {
            i = {
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                ["<CR>"]  = actions.select_default + actions.center,
            }
        }

        -- 2. Only inject trouble mappings if the plugin successfully loaded
        if has_trouble then
            custom_mappings.i["<c-t>"] = trouble.open
        end

        require("telescope").setup({
            defaults = {
                layout_config = {
                    width = 0.75,
                    prompt_position = "top",
                    preview_cutoff = 120,
                    horizontal = { mirror = false },
                    vertical = { mirror = false },
                },
                sorting_strategy = "ascending",
                prompt_prefix = "   ",
                selection_caret = " ",
                path_display = { "truncate" },
                file_ignore_patterns = { ".git/", ".idea/", ".vscode/", "htdocs/" },
                mappings = custom_mappings,
            },
        })

        -- 3. Safely load extensions
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "live_grep_args")
    end,
}
