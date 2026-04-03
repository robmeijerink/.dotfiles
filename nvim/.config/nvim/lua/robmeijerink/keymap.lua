-- =========================================================
-- Core Keymaps (Rob Meijerink Architecture)
-- =========================================================
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Maintain the cursor position when yanking a visual selection
map('v', 'y', 'myy`y', opts)
map('v', 'Y', 'myY`y', opts)

-- Disable annoying command line history window
map('n', 'q:', ':q<CR>', opts)

-- Easy insertion of a trailing ; or , from insert mode
map('i', ';;', '<Esc>A;<Esc>', opts)
map('i', ',,', '<Esc>A,<Esc>', opts)

-- Move text up and down
map('i', '<A-j>', '<Esc>:move .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:move .-2<CR>==gi', opts)
map('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
map('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Let Y act same as D and C, Yank till end of line
map('n', 'Y', 'yg$', opts)

-- Better join lower line into current
map('n', 'J', 'mzJ`z', opts)
map('n', '<leader>J', ':TSJToggle<CR>', opts)

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Scroll and center
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
map('n', '<C-Up>', '<cmd>resize -2<CR>', opts)
map('n', '<C-Down>', '<cmd>resize +2<CR>', opts)
map('n', '<C-Right>', '<cmd>vertical resize -2<CR>', opts)
map('n', '<C-Left>', '<cmd>vertical resize +2<CR>', opts)

-- Navigate buffers
map('n', '<S-l>', '<cmd>bnext<CR>', opts)
map('n', '<S-h>', '<cmd>bprevious<CR>', opts)

-- Command mode shortcuts
map('c', 'w!!', 'w !sudo tee %', opts)
map('c', 'x!!', '<cmd>!chmod +x %<CR>', opts)

-- Insert mode quick escapes
map('i', '<C-c>', '<Esc>', opts)

-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move text up and down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Replace with paste in Visual Block mode without yanking target
map('x', '<leader>p', '"_dP', opts)

-- Yank to system clipboard
map('n', '<leader>y', '"+y', opts)
map('v', '<leader>y', '"+y', opts)
map('n', '<leader>Y', '"+yg$', opts)

-- Delete without cut
map('n', '<leader>d', '"_d', opts)
map('v', '<leader>d', '"_d', opts)

-- Show diff of unsaved changes compared to last saved version
map('n', '<leader>D%', ':w !diff % -<CR>', opts)

-- Reselect last pasted text
map('n', 'gp', '`[v`]', opts)

-- No operations
map('n', '<leader>Q', '<cmd>quit<CR>', opts)
map('n', 'Q', '<nop>', opts)

-- Unset "last search pattern" register by hitting return
map('n', '<CR>', '<cmd>noh<CR><CR>', opts)

-- Quickfix list navigation
map('n', '<C-J>', '<cmd>cnext<CR>zz', opts)
map('n', '<C-K>', '<cmd>cprev<CR>zz', opts)
map('n', '<leader>k', '<cmd>lnext<CR>zz', opts)
map('n', '<leader>j', '<cmd>lprev<CR>zz', opts)

-- Substitute current word
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts)

-- General workflow
map('n', '<leader>w', '<cmd>w<CR>', { desc = "Save" })
map('n', '<leader>x', '<cmd>Bdelete<CR>', { desc = "Close" })
map('n', '<leader>X', '<cmd>Bdelete!<CR>', { desc = "Force Close" })


-- =========================================================
-- Plugin Specific Keymaps (Legacy)
-- Note: These will move to their respective lua/plugins/*.lua files
-- =========================================================

-- Nvim Tree & Explorer
map('n', '<leader>ew', '<cmd>NvimTreeFindFileToggle<CR>', opts)
map('n', '<leader>ee', vim.cmd.Ex, { desc = "Ex" })

-- ToggleTerm & Tmux
map('n', '<C-\\>', '<cmd>ToggleTerm direction=float<CR>', opts)
map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', opts)
map('n', '\x74\r', '<cmd>silent !tmux neww t<CR>', opts)

-- Telescope
map('n', '<leader>ft', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Find and open in tmux' })
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = "Find Files" })
map('n', '<leader>fa', "<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, hidden = true, prompt_title = 'All Files' })<CR>", { desc = "All Files" })
map('n', '<leader>fG', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Telescope Live Grep (args)" })
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ') })<CR>", { desc = "Telescope Live Grep in Word" })
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>', { desc = "Telescope Grep Word" })
map('n', '<leader>fv', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>", { desc = "Find word under cursor" })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = "Open Recent File" })
map('n', '<leader>fr', '<cmd>Telescope resume<CR>', { desc = "Resume Search" })
map('n', '<leader>fx', '<cmd>Telescope buffers show_all_buffers=true<CR>', { desc = "Telescope Buffer" })
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = "Telescope Help Tags" })

-- Buffers (Bufferline)
map('n', '<leader>bn', '<cmd>enew<CR>', { desc = 'New buffer' })
map('n', '<leader>ba', '<cmd>bufdo Bwipeout<CR>', { desc = 'Close all buffers' })
map('n', '<leader>br', '<cmd>BufferLineCloseRight<CR>', { desc = 'Close buffers to the right' })
map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<CR>', { desc = 'Close buffers to the left' })
map('n', '<leader>bo', "<cmd>%Bdelete|e#|Bdelete#<CR>|'<CR>", { desc = 'Close other buffers' })

-- Git / LazyGit / Gitsigns
map('n', 'gh', '<cmd>diffget //2<CR>', opts)
map('n', 'gl', '<cmd>diffget //3<CR>', opts)
map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'LazyGit' })
map('n', '<leader>gp', '<cmd>Git pull<CR>', { desc = 'Git pull' })
map('n', '<leader>gP', '<cmd>Git push<CR>', { desc = 'Git push' })

-- Harpoon (Example shortcuts)
map('n', '<leader>hh', "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = 'Add Mark' })
map('n', '<leader>hl', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = 'Toggle Quick Menu' })
map('n', '<leader>1', "<cmd> lua require('harpoon.ui').nav_file(1)<CR>", { desc = 'Go to Mark 1' })
map('n', '<leader>2', "<cmd> lua require('harpoon.ui').nav_file(2)<CR>", { desc = 'Go to Mark 2' })
