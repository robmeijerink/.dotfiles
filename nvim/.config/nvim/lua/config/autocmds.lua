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
        vim.highlight.on_yank({
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

-- 6. Filetype specific indentation & formatting
local filetype_group = augroup('FiletypeSettings', { clear = true })

-- Blade
autocmd({ "BufNewFile", "BufRead" }, {
    group = filetype_group,
    pattern = "*.blade.php",
    callback = function()
        vim.bo.filetype = "blade"
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- Python
autocmd("FileType", {
    group = filetype_group,
    pattern = "python",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- Markdown
autocmd({ "BufNewFile", "BufRead" }, {
    group = filetype_group,
    pattern = { "*.md", "*.ppmd", "*.markdown" },
    callback = function()
        vim.bo.filetype = "markdown"
        vim.opt_local.textwidth = 80
    end,
})

-- Slimbars
autocmd({ "BufNewFile", "BufRead" }, {
    group = filetype_group,
    pattern = "*.slimbars",
    callback = function()
        vim.bo.syntax = "slim"
    end,
})

-- Makefiles (Require actual tabs, no spaces)
autocmd({ "BufEnter", "BufWinEnter" }, {
    group = filetype_group,
    pattern = { "Makefile", "*.make" },
    callback = function()
        vim.opt_local.expandtab = false
    end,
})
