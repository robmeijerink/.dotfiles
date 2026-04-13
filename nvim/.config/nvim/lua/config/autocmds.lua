-- =========================================================
-- Core Autocommands (Rob Meijerink)
-- =========================================================
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General group to prevent duplicate attachments
local general_group = augroup('RobMeijerinkGeneral', { clear = true })

-- 1. Highlight text when yanking
autocmd('TextYankPost', {
    group = augroup('HighlightYank', { clear = true }),
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- 2. Remove whitespace on saving a file
autocmd("BufWritePre", {
    group = general_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- 3. Restore cursor position when opening a file
autocmd('BufReadPost', {
    group = general_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- 4. Ensure everything is unfolded when opening a buffer (Treesitter folds)
autocmd({ "BufReadPost", "FileReadPost" }, {
    group = general_group,
    pattern = "*",
    callback = function()
        vim.opt.foldlevel = 99
    end,
})

-- 5. Dynamic Cursorline (Only active in current window and normal mode)
local cursorline_group = augroup('CursorLineControl', { clear = true })
autocmd({ "WinEnter", "InsertLeave" }, {
    group = cursorline_group,
    pattern = "*",
    callback = function()
        vim.opt_local.cursorline = true
    end,
})
autocmd({ "WinLeave", "InsertEnter" }, {
    group = cursorline_group,
    pattern = "*",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- =========================================================
-- Dynamic Whitespace Warnings
-- Only show tabs if indents is spaces and vice versa
-- =========================================================
vim.api.nvim_create_autocmd({
    "BufEnter",
    "FileType",
    -- "OptionSet", Disable for now to reduce overhead, but used when changing setting in open file
}, {
    group = vim.api.nvim_create_augroup("DynamicIndentWarnings", { clear = true }),
    pattern = "*",
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then return end
        local wants_spaces = vim.bo[args.buf].expandtab

        vim.opt_local.list = true

        if wants_spaces then
            vim.opt_local.listchars = {
                tab = "» ",
                lead = " ",
                trail = "•",
            }
        else
            vim.opt_local.listchars = {
                tab = "  ",
                lead = "·",
                trail = "•",
            }
        end
    end,
})
