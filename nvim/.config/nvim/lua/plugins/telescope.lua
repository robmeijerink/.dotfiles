-- =========================================================
-- Plugin: telescope.nvim (Refined Solvalutions Edition)
-- Focus: Deep project search, LGA integration, and Trouble bridge
-- =========================================================
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-live-grep-args.nvim",
        "folke/trouble.nvim",
        -- Optional: add these if you use the extensions
        "kdheepak/lazygit.nvim",
        "mfussenegger/nvim-dap",
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>",                                                                desc = "Find Files" },
        {
            "<leader>fa",
            function()
                require('telescope.builtin').find_files({
                    no_ignore = true,
                    hidden = true,
                    prompt_title =
                    'All Files'
                })
            end,
            desc = "All Files"
        },
        { "<leader>fg", function() require('telescope').extensions.live_grep_args.live_grep_args() end,                 desc = "Live Grep (Args)" },
        { "<leader>fw", "<cmd>Telescope grep_string<CR>",                                                               desc = "Grep Word" },
        { "<leader>fv", function() require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') }) end, desc = "Find word under cursor" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>",                                                                  desc = "Recent Files" },
        { "<leader>fr", "<cmd>Telescope resume<CR>",                                                                    desc = "Resume Search" },
        { "<leader>fx", "<cmd>Telescope buffers show_all_buffers=true<CR>",                                             desc = "Telescope Buffers" },
        { "<leader>fd", "<cmd>Telescope diagnostics<CR>",                                                               desc = "Diagnostics" },
        { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",                                                      desc = "Document Symbols" },
        -- Added the ones from your source
        { "<leader>fm", "<cmd>Telescope harpoon marks<CR>",                                                             desc = "Harpoon Marks" },
        { "<leader>fc", "<cmd>Telescope commands<CR>",                                                                  desc = "Telescope Commands" },
        { "<leader>fk", "<cmd>Telescope keymaps<CR>",                                                                   desc = "Keymaps" },
    },
    config = function()
        local actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        -- Safe require for Trouble
        local has_trouble, trouble = pcall(require, "trouble.sources.telescope")

        local grep_args = { '--hidden', '--glob', '!**/.git/*' }

        require("telescope").setup({
            defaults = {
                layout_config = {
                    width = 0.75,
                    prompt_position = "top",
                    preview_cutoff = 120,
                    horizontal = { mirror = false },
                    vertical = { mirror = false },
                },
                find_command = {
                    'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--iglob',
                    '!.git', '--hidden', '--no-ignore-vcs'
                },
                prompt_prefix = " 󰍉 ",
                selection_caret = " ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "descending",
                layout_strategy = "horizontal",
                file_ignore_patterns = { ".git", ".idea", ".vscode", "htdocs" },
                path_display = { "truncate" },
                winblend = 0,
                color_devicons = true,
                set_env = { ['COLORTERM'] = 'truecolor' },

                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<esc>"] = actions.close,
                        ["<CR>"]  = actions.select_default + actions.center,
                        ["<C-t>"] = has_trouble and trouble.open or nil,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<C-t>"] = has_trouble and trouble.open or nil,
                    }
                },
            },
            pickers = {
                find_files = {
                    find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
                },
                live_grep = {
                    additional_args = function() return grep_args end
                },
                grep_string = {
                    additional_args = function() return grep_args end
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt({ postfix = " --hidden --no-ignore" }),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob --hidden --no-ignore" }),
                        },
                    },
                }
            }
        })

        -- Load extensions
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "live_grep_args")
        pcall(require("telescope").load_extension, "lazygit")
        pcall(require("telescope").load_extension, "dap")
    end,
}
