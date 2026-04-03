-- =========================================================
-- Plugin: Productivity Suite (Rob Meijerink Architecture)
-- =========================================================
return {
    -- 1. Harpoon (Quick file switching)
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon Mark" },
            { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
            { "<leader>h1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon 1" },
            { "<leader>h2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon 2" },
        },
    },

    -- 2. Undotree (Visual undo history)
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
        },
    },

    -- 3. TreeSJ (Split/Join code blocks)
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        keys = {
            { "<leader>m", function() require('treesj').toggle() end, desc = "Toggle Split/Join" },
        },
        opts = {
            use_default_keymaps = false,
            check_syntax_error = true,
            max_join_length = 12000,
            cursor_behavior = 'hold',
        }
    },

    -- 4. Neoscroll (Smooth scrolling)
    {
        'karb94/neoscroll.nvim',
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                mappings = {
                    ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '50' } },
                    ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '50' } },
                }
            })
        end,
    },

    -- 5. Tmux Navigator (Seamless navigation)
    { 'christoomey/vim-tmux-navigator', lazy = false },
}
