-- =========================================================
-- Core Keymaps (Rob Meijerink)
-- =========================================================
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. General & Navigation
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', '<C-d>', '<C-d>zz', opts)         -- Scroll and center
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)               -- Next search and center
map('n', 'N', 'Nzzzv', opts)
map('n', '<CR>', '<cmd>noh<CR><CR>', opts) -- Clear search highlight
map('n', 'Q', '<nop>', opts)               -- Disable accidental Ex-mode
map('n', 'q:', ':q<CR>', opts)             -- Fix for common typo

-- 2. Window & Buffer Management
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-Up>', '<cmd>resize -2<CR>', opts)
map('n', '<C-Down>', '<cmd>resize +2<CR>', opts)
map('n', '<C-Right>', '<cmd>vertical resize -2<CR>', opts)
map('n', '<C-Left>', '<cmd>vertical resize +2<CR>', opts)

-- use vim-impaired, [b and next is ]b.
-- map('n', '<S-l>', '<cmd>bnext<CR>', opts)
-- map('n', '<S-h>', '<cmd>bprevious<CR>', opts)

-- 3. Clipboard & Editing Logic (Senior Dev Shortcuts)
map('v', 'y', 'myy`y', opts)            -- Maintain position when yanking
map('n', 'Y', 'yg$', opts)              -- Yank till end of line
map('n', 'J', 'mzJ`z', opts)            -- Join lines and keep cursor
map('v', 'J', ":m '>+1<CR>gv=gv", opts) -- Move selection down
map('v', 'K', ":m '<-2<CR>gv=gv", opts) -- Move selection up
map('i', '<A-j>', '<Esc>:move .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:move .-2<CR>==gi', opts)
map('x', '<leader>p', '"_dP', opts) -- Paste without losing register
map('n', '<leader>y', '"+y', opts)  -- System clipboard yank
map('v', '<leader>y', '"+y', opts)
map('n', '<leader>Y', '"+yg$', opts)
map('n', '<leader>d', '"_d', opts) -- Delete without yanking
map('v', '<leader>d', '"_d', opts)
map('v', '<', '<gv', opts)         -- Stay in indent mode
map('v', '>', '>gv', opts)
map('n', 'gp', '`[v`]', opts)      -- Reselect last pasted text

-- 4. Terminal & Shell
map('i', '<C-c>', '<Esc>', opts) -- Quick escape

-- Handled by tmux-navigation plugin now
-- map('t', '<C-h>', [[<C-\><C-N><C-w>h]], opts)
-- map('t', '<C-j>', [[<C-\><C-N><C-w>j]], opts)
-- map('t', '<C-k>', [[<C-\><C-N><C-w>k]], opts)
-- map('t', '<C-l>', [[<C-\><C-N><C-w>l]], opts)

-- 5. Search & Replace (Native & Spectre)
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })

-- 6. Quickfix & Location List
map('n', '<C-J>', '<cmd>cnext<CR>zz', opts)
map('n', '<C-K>', '<cmd>cprev<CR>zz', opts)
map('n', '<leader>k', '<cmd>lnext<CR>zz', opts)
map('n', '<leader>j', '<cmd>lprev<CR>zz', opts)

-- 8. Telescope (Essential Pickers)
map('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files()<CR>", opts)
map('n', '<leader>?', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { desc = "Recent Files" })
map('n', '<leader><space>', "<cmd>lua require('telescope.builtin').buffers()<CR>", { desc = "Buffers" })
map('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "Search in Buffer" })

-- Block Ex. mode
map('n', 'Q', '<cmd>q<cr>', { desc = "Close current window/split" })

-- 10. Workspace & Files
map('n', '<leader>w', '<cmd>w<CR>', { desc = "Save" })
map('n', '<leader>bc', '<cmd>enew<cr>', { desc = "Buffer New (Create Empty)" })
map('n', '<leader>x', '<cmd>Bdelete<CR>', { desc = "Close Buffer" })
map('n', '<leader>X', '<cmd>Bdelete!<CR>', { desc = "Force Close Buffer (Lose Changes)" })

-- Close all buffers except the current active one
vim.keymap.set("n", "<leader>bo", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local all_bufs = vim.api.nvim_list_bufs()

    for _, buf in ipairs(all_bufs) do
        -- Check if it is not the current buffer, is valid, and is actually a listed file
        if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
            -- Delete the buffer securely. Protected call prevents crash on unsaved files.
            pcall(vim.api.nvim_buf_delete, buf, { force = false })
        end
    end

    vim.notify("Cleaned up background buffers", vim.log.levels.INFO)
end, { desc = "Close all OTHER buffers" })


map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', opts) -- Tmux magic

-- =========================================================
-- Native Built-in Plugins (Lazy Loaded)
-- =========================================================

vim.keymap.set("n", "<leader>U", function()
    -- 1. Load the builtin plugin into memory (Zero startup overhead)
    vim.cmd("packadd nvim.undotree")

    -- 2. Toggle the native visual tree window
    vim.cmd("Undotree")
end, { desc = "Toggle Undotree" })
