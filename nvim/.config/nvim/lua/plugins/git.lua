-- =========================================================
-- Plugin: Git Suite (Optimized for Workflow & Performance)
-- =========================================================
return {
    -- 1. Gitsigns (Live indicators in the gutter & Blame)
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                -- during rapid O(N) scrolling while keeping the live blame feature active.
                update_debounce = 500,
                current_line_blame = true,
                sign_priority = 20,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation: Hunk jumping (O(1) execution)
                    map('n', ']h', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Next Hunk" })

                    map('n', '[h', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Prev Hunk" })

                    -- Manual triggers for deep inspection
                    map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Git blame line full" })
                    map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview git hunk" })
                end
            })
        end
    },

    -- 2. LazyGit (The visual cockpit)
    {
        'kdheepak/lazygit.nvim',
        cmd = {
            "LazyGit",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
            "LazyGitConfig",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<CR>",                  desc = "Toggle LazyGit" },
            { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "LazyGit File History" },
        },
        -- CRITICAL: 'init' block ensures globals are loaded BEFORE the plugin starts
        init = function()
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            vim.g.lazygit_floating_window_use_plenary = 0

            -- Security/Workflow fix: Prevents nested Neovim instances (Inception)
            -- when editing a file directly from the LazyGit UI.
            vim.g.lazygit_use_neovim_remote = 1
        end,
    },

    -- 3. Fugitive (The direct Git engine)
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        dependencies = { "tpope/vim-rhubarb" },
        keys = {
            { "<leader>G", ":Git ", desc = "Git (Fugitive) prompt" },
        }
    },

    -- 4. Diffview (Deep diff analysis)
    {
        'sindrets/diffview.nvim',
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = true,
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<CR>",  desc = "Open Diffview" },
            { "<leader>gx", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
        }
    }
}
