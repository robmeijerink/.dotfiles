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

local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local cnoremap = Remap.cnoremap
local nmap = Remap.nmap

-- Normal --
-- Better window navigation
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')

-- Resize with arrows
nnoremap('<C-Up>', '<cmd>resize -2<CR>')
nnoremap('<C-Down>', '<cmd>resize +2<CR>')
nnoremap('<C-Right>', '<cmd>vertical resize -2<CR>')
nnoremap('<C-Left>', '<cmd>vertical resize +2<CR>')

-- Navigate buffers
nnoremap('<S-l>', '<cmd>bnext<CR>')
nnoremap('<S-h>', '<cmd>bprevious<CR>')

-- Move text up and down
nnoremap('<A-j>', '<Esc><cmd>m .+1<CR>==gi')
nnoremap('<A-k>', '<Esc><cmd>m .-2<CR>==gi')

-- Command --
-- Resave with sudo
cnoremap('w!!', 'w !sudo tee %')
cnoremap('x!!', '<cmd>!chmod +x %<CR>')

-- Insert --
-- Press zx fast to exit insert mode
inoremap('zx', '<ESC>')

-- Visual --
-- Press zx fast to exit visual mode
vnoremap('zx', '<ESC>')
-- Stay in indent mode
vnoremap('<', '<gv')
vnoremap('>', '>gv')

-- Move text up and down
vnoremap('<A-j>', '<cmd>m .+1<CR>==')
vnoremap('<A-k>', '<cmd>m .-2<CR>==')
vnoremap('p', '"_dP')

-- Visual Block --
-- Move text up and down
xnoremap('J', "<cmd>move '>+1<CR>gv-gv")
xnoremap('K', "<cmd>move '<-2<CR>gv-gv")
xnoremap('<A-j>', "<cmd>move '>+1<CR>gv-gv")
xnoremap('<A-k>', "<cmd>move '<-2<CR>gv-gv")

-- Replace with paste in Visual Block mode
xnoremap('<leader>p', '"_dP')

-- Yank to system's clipboard
nnoremap('<leader>y', '"+y')
vnoremap('<leader>y', '"+y')
nnoremap('<leader>Y', '"+Y', { noremap = false, silent = true })

-- Delete without cut
nnoremap('<leader>d', '"_d')
vnoremap('<leader>d', '"_d')

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- This unsets the "last search pattern" register by hitting return
nnoremap('<CR>', '<cmd>noh<CR><CR>')

-- This replaces the current word
nnoremap('<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- PLUGINS --

-- Lazygit
-- nnoremap('<leader>lg', '<cmd>LazyGit<CR>')

-- Telescope
-- nnoremap('<C-p>', "<cmd>lua require('telescope.builtin').git_files(require('telescope.themes'))<CR>")
-- nnoremap('<leader>f', "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>")
-- nnoremap('<leader>ff', "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes'))<CR>")
-- nnoremap('<leader>fg', "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes'))CR>")
-- nnoremap('<leader>bb', "<cmd>lua require('telescope.builtin').buffer(require('telescope.themes'))<CR>")
-- nnoremap('<leader>hh', "<cmd>lua require('telescope.builtin').help_tags(require('telescope.themes'))<CR>")
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Undotree
nnoremap('<leader>u', '<cmd>UndotreeShow<CR>')

-- Nvim Tree
nnoremap('<leader>e', '<cmd>NvimTreeToggle<CR>')

-- LSP Saga
nnoremap("<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
nnoremap("<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")

-- Tmux Sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
