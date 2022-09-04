local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
-- keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', '<cmd>resize -2<CR>', opts)
keymap('n', '<C-Down>', '<cmd>resize +2<CR>', opts)
keymap('n', '<C-Right>', '<cmd>vertical resize -2<CR>', opts)
keymap('n', '<C-Left>', '<cmd>vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', '<cmd>bnext<CR>', opts)
keymap('n', '<S-h>', '<cmd>bprevious<CR>', opts)

-- Move text up and down
keymap('n', '<A-j>', '<Esc><cmd>m .+1<CR>==gi', opts)
keymap('n', '<A-k>', '<Esc><cmd>m .-2<CR>==gi', opts)

-- Command --
-- Resave with sudo
keymap('c', 'w!!', 'w !sudo tee %', opts)
keymap('c', 'x!!', '<cmd>!chmod +x %<CR>', opts)

-- Insert --
-- Press zx fast to exit insert mode
keymap('i', 'zx', '<ESC>', opts)

-- Visual --
-- Press zx fast to exit visual mode
keymap('v', 'zx', '<ESC>', opts)
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', '<cmd>m .+1<CR>==', opts)
keymap('v', '<A-k>', '<cmd>m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', "<cmd>move '>+1<CR>gv-gv", opts)
keymap('x', 'K', "<cmd>move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', "<cmd>move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', "<cmd>move '<-2<CR>gv-gv", opts)

-- Replace with paste in Visual Block mode
keymap('x', '<leader>p', '"_dP', opts)

-- Yank to system's clipboard
keymap('n', '<leader>y', '"+y', opts)
keymap('v', '<leader>y', '"+y', opts)
keymap('n', '<leader>Y', '"+Y', { noremap = false, silent = true })

-- Delete without cut
keymap('n', '<leader>d', '"_d', opts)
keymap('v', '<leader>d', '"_d', opts)

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- This unsets the "last search pattern" register by hitting return
keymap('n', '<CR>', '<cmd>noh<CR><CR>', opts)

-- This replaces the current word
keymap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts)

-- PLUGINS --

-- Lazygit
-- keymap('n', '<leader>lg', '<cmd>LazyGit<CR>', opts)

-- Telescope
-- keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').git_files(require('telescope.themes'))<CR>", opts)
-- keymap('n', '<leader>f', "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>", opts)
-- keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes'))<CR>", opts)
-- keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes'))CR>", opts)
-- keymap('n', '<leader>bb', "<cmd>lua require('telescope.builtin').buffer(require('telescope.themes'))<CR>", opts)
-- keymap('n', '<leader>hh', "<cmd>lua require('telescope.builtin').help_tags(require('telescope.themes'))<CR>", opts)
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Undotree
keymap('n', '<leader>u', '<cmd>UndotreeShow<CR>', opts)

-- Nvim Tree
keymap('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)

-- LSP Saga
keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)

-- Tmux Sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
