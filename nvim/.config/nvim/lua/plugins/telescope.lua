-- =========================================================
-- Plugin: Telescope (Rob Meijerink)
-- =========================================================
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-live-grep-args.nvim',
        'kdheepak/lazygit.nvim',
    },
    keys = {
        -- Core Nav (Preserving your keymap.lua logic)
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>fa", function() require('telescope.builtin').find_files({ no_ignore = true, hidden = true }) end, desc = "All Files" },
        { "<leader>fG", function() require('telescope').extensions.live_grep_args.live_grep_args() end, desc = "Grep (Args)" },
        { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Grep Word" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
        { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "Resume Search" },
        { "<leader>fx", "<cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Telescope Buffers" },
        -- Tmux integration from your keymap
        { "<leader>ft", "<cmd>silent !tmux neww tmux-sessionizer<CR>", desc = "Tmux Sessionizer" },
    },
    config = function()
        local actions = require('telescope.actions')
        local trouble = require("trouble.sources.telescope")
        local lga_actions = require("telescope-live-grep-args.actions")
        local grep_args = { '--hidden', '--glob', '!**/.git/*' }

        require('telescope').setup({
            defaults = {
                layout_config = {
                    width = 0.75,
                    prompt_position = "top",
                    preview_cutoff = 120,
                    horizontal = { mirror = false },
                    vertical = { mirror = false }
                },
                sorting_strategy = "ascending", -- Needed for top prompt_position
                prompt_prefix = " 󰍉 ",
                selection_caret = " ",
                path_display = { "truncate" },
                file_ignore_patterns = { ".git/", ".idea/", ".vscode/", "htdocs/" },

                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default + actions.center,
                        ["<C-t>"] = trouble.open,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<C-t>"] = trouble.open,
                    }
                },
                borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
            },
            pickers = {
                find_files = {
                    find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
                },
                live_grep = { additional_args = function() return grep_args end },
                grep_string = { additional_args = function() return grep_args end },
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
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'live_grep_args')
        pcall(require('telescope').load_extension, 'lazygit')
        -- DAP is loaded in debug.lua
    end
}
