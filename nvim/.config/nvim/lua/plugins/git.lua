-- =========================================================
-- Plugin: Git Suite (Rob Meijerink)
-- =========================================================
return {
    -- 1. Gitsigns (Live indicators in the gutter)
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                update_debounce = 250,
                current_line_blame = true,
                sign_priority = 20,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation: Hunk jumping
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
            { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Toggle LazyGit" },
        },
        config = function()
            -- Floating window settings
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            vim.g.lazygit_floating_window_corner_chars = { '╭', '╮', '╰', '╯' }
            vim.g.lazygit_floating_window_use_plenary = 0
            vim.g.lazygit_use_neovim_remote = 0
        end,
    },

    -- 3. Fugitive (The direct Git engine)
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        dependencies = { "tpope/vim-rhubarb" },
    },

    -- 4. Diffview (Deep diff analysis)
    {
        'sindrets/diffview.nvim',
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = true,
    }
}
