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
        "folke/trouble.nvim",
    },
    keys = {
        -- Basic File Pickers
        { "<leader>ff", "<cmd>Telescope find_files<CR>",                                                                   desc = "Find Files" },
        { "<leader>fa", function() require('telescope.builtin').find_files({ no_ignore = true, hidden = true }) end,       desc = "All Files" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>",                                                                     desc = "Recent Files" },
        { "<leader>?",  "<cmd>Telescope oldfiles<CR>",                                                                     desc = "Recent Files (Quick)" },

        -- Search / Grep Logic (Optimized for performance)
        { "<leader>fg", function() require('telescope').extensions.live_grep_args.live_grep_args() end,                    desc = "Live Grep (Args)" },
        { "<leader>fw", "<cmd>Telescope grep_string<CR>",                                                                  desc = "Grep Word under Cursor" },
        { "<leader>fv", function() require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ') }) end, desc = "Grep manual input" },

        -- Navigation & Refactoring
        { "<leader>fx", "<cmd>Telescope buffers show_all_buffers=true<CR>",                                                desc = "Telescope Buffers" },
        { "<leader>fr", "<cmd>Telescope resume<CR>",                                                                       desc = "Resume Search" },
        { "<leader>fd", "<cmd>Telescope diagnostics<CR>",                                                                  desc = "LSP Diagnostics" },
        { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",                                                         desc = "Document Symbols" },
        { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",                                                desc = "Workspace Symbols" },

        -- Meta / UI Pickers
        { "<leader>fh", "<cmd>Telescope help_tags<CR>",                                                                    desc = "Help Tags" },
        { "<leader>fk", "<cmd>Telescope keymaps<CR>",                                                                      desc = "Keymaps" },
        { "<leader>fc", "<cmd>Telescope commands<CR>",                                                                     desc = "Commands" },
        { "<leader>fm", "<cmd>Telescope harpoon marks<CR>",                                                                desc = "Harpoon Marks" },

        -- PERF NOTE: <leader>ft (tmux-sessionizer) is handled in keymaps.lua to avoid loading Telescope.
    },
    config = function()
        local actions = require("telescope.actions")

        -- 1. Safe require for Trouble integration
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

        -- 2. Safely load extensions
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "live_grep_args")
        pcall(require("telescope").load_extension, "harpoon")
    end,
}
