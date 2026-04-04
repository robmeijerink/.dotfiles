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
map('n', '<leader>SS', "<cmd>lua require('spectre').open()<CR>", { desc = "Spectre" })
map('n', '<leader>SW', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Spectre Word" })
map('n', '<leader>SP', "viw:lua require('spectre').open_file_search()<CR>", { desc = "Spectre in File" })

-- 6. Quickfix & Location List
map('n', '<C-J>', '<cmd>cnext<CR>zz', opts)
map('n', '<C-K>', '<cmd>cprev<CR>zz', opts)
map('n', '<leader>k', '<cmd>lnext<CR>zz', opts)
map('n', '<leader>j', '<cmd>lprev<CR>zz', opts)

-- 7. Git (Fugitive & Diffview)
map('n', 'gh', '<cmd>diffget //2<CR>', opts)
map('n', 'gl', '<cmd>diffget //3<CR>', opts)
map('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = "Git Pull" })
map('n', '<leader>gP', '<cmd>Git push<CR>', { desc = "Git Push" })
map('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = "Git Diff" })
map('n', '<leader>gq', '<cmd>DiffviewClose<CR>', { desc = "Close Diffview" })

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

-- 9. Productivity (Harpoon, Treesj, Zen)
map('n', '<leader>J', '<cmd>TSJToggle<CR>', { desc = "Split/Join" })
map('n', '<leader>zz', '<cmd>ZenMode<CR>', { desc = "Zen Mode" })
map('n', '<leader>zt', '<cmd>Twilight<CR>', { desc = "Twilight" })
map('n', '<leader>**', '<cmd>Neogen<CR>', { desc = "Generate Docs" })

-- 10. Workspace & Files
map('n', '<leader>w', '<cmd>w<CR>', { desc = "Save" })
map('n', '<leader>x', '<cmd>Bdelete<CR>', { desc = "Close Buffer" })
map('n', '<leader>ee', vim.cmd.Ex, { desc = "Netrw" })
map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', opts) -- Tmux magic

map('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

map("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Code Format" })

-- =========================================================
-- Debugging (DAP) Keymaps
-- =========================================================
local dap = require("dap")
local dapui = require("dapui")

map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "Debug: Conditional Breakpoint" })
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
