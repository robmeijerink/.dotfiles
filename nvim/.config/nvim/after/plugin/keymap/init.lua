-- local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
-- local nmap = Remap.nmap
-- local vmap = Remap.vmap

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
nnoremap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
nnoremap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap('y', 'myy`y')
vnoremap('Y', 'myY`y')

-- Disable annoying command line thing
nnoremap('q:', ':q<CR>')

-- Easy insertion of a trailing ; or , from insert mode
inoremap(';;', '<Esc>A;<Esc>')
inoremap(',,', '<Esc>A,<Esc>')

-- Move text up and down
inoremap('<A-j>', '<Esc>:move .+1<CR>==gi')
inoremap('<A-k>', '<Esc>:move .-2<CR>==gi')
xnoremap('<A-j>', ":move '>+1<CR>gv-gv")
xnoremap('<A-k>', ":move '<-2<CR>gv-gv")

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Normal --
-- Let Y act same as D and C, Yank till end of line.
nnoremap("Y", "yg$")

-- Better join lower line into current
nnoremap("J", "mzJ`z")
nnoremap("<leader>J", ":TSJToggle<CR>")

-- Better window navigation
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')

-- Scroll and center
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Resize with arrows
nnoremap('<C-Up>', '<cmd>resize -2<CR>')
nnoremap('<C-Down>', '<cmd>resize +2<CR>')
nnoremap('<C-Right>', '<cmd>vertical resize -2<CR>')
nnoremap('<C-Left>', '<cmd>vertical resize +2<CR>')

-- Navigate buffers
nnoremap('<S-l>', '<cmd>bnext<CR>')
nnoremap('<S-h>', '<cmd>bprevious<CR>')

-- Command --
-- Resave with sudo
cnoremap('w!!', 'w !sudo tee %')
cnoremap('x!!', '<cmd>!chmod +x %<CR>')

-- Insert --
-- Press zx fast to exit insert mode
-- inoremap('zx', '<ESC>')

-- This is going to get me cancelled
inoremap("<C-c>", "<Esc>")

-- Visual --
-- Press zx fast to exit visual mode
-- vnoremap('zx', '<ESC>')

-- Stay in indent mode
vnoremap('<', '<gv')
vnoremap('>', '>gv')

-- Move text up and down
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Don't yank paste target
-- vnoremap('p', '"_dP')

-- Visual Block --

-- Replace with paste in Visual Block mode
xnoremap('<leader>p', '"_dP')

-- Other
-- Yank till end of line
nnoremap("Y", "yg$")
nnoremap("<leader>Y", "\"+yg$")

-- Yank to system's clipboard
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")

-- Delete without cut
nnoremap('<leader>d', '"_d')
vnoremap('<leader>d', '"_d')

-- Show diff of unsaved changes compared to last saved version.
nnoremap('<leader>D%', ':w !diff % -<CR>')

-- Reselect last pasted text
nnoremap('gp', '`[v`]')

-- No operation: cancel
nnoremap("<leader>Q", "<cmd>quit<CR>")

-- No operation: cancel
nnoremap("Q", "<nop>")

-- This unsets the "last search pattern" register by hitting return
nnoremap('<CR>', '<cmd>noh<CR><CR>')

-- Quickfix list
nnoremap("<C-J>", "<cmd>cnext<CR>zz")
nnoremap("<C-K>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

-- This replaces the current word
nnoremap('<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Formatting
nnoremap('<leader>F', function()
    vim.lsp.buf.format({
        timeout_ms = 10000,
        -- filter = function(client)
        --     return client.name == "null-ls"
        -- end
    })
end, { desc = 'Format File' })

-- Substitute current word
nnoremap('<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Generate docblock
nnoremap("<Leader>**", ":Neogen<CR>")

-- Undotree
nnoremap('<leader>U', '<cmd>UndotreeToggle<CR>')

-- Nvim Tree
nnoremap('<leader>ew', '<cmd>NvimTreeFindFileToggle<CR>')

-- Explorer
nnoremap('<leader>ee', vim.cmd.Ex, { desc = "Ex" })

-- ToggleTerm
nnoremap("<C-\\>", "<cmd>ToggleTerm direction=float<CR>")

-- Tmux Sessionizer
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- Ctrl+Shift+F - t
nnoremap("\x74\r", "<cmd>silent !tmux neww t<CR>")

-- Git
nnoremap("gh", "<cmd>diffget //2<CR>")
nnoremap("gl", "<cmd>diffget //3<CR>")

-- General Mappings --

-- Mappings
nnoremap('<leader>w', "<cmd>w<CR>", { desc = "Save" })
nnoremap('<leader>p', ':set paste<CR>"*p:set nopaste<CR>', { desc = "Paste in Paste Mode" })
nnoremap('<leader>x', "<cmd>Bdelete<CR>", { desc = "Close" })
nnoremap('<leader>X', "<cmd>Bdelete!<CR>", { desc = "Close" })

-- Find mappings
nnoremap('<leader>ft', "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = 'Find and open in tmux' })
nnoremap('<leader>ff', "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
nnoremap('<leader>fa', "<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, hidden = true, prompt_title = 'All Files' })<CR>", { desc = "All Files" })
nnoremap('<leader>fG', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Telescope Live Grep (args)" })
nnoremap('<leader>fg', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ') })<CR>", { desc = "Telescope Live Grep in Word" })
nnoremap('<leader>fw', "<cmd>Telescope grep_string<CR>", { desc = "Telescope Grep Word" })
nnoremap('<leader>fv', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>", { desc = "Find word under cursor" })
nnoremap('<leader>fo', "<cmd>Telescope oldfiles<CR>", { desc = "Open Recent File" })
nnoremap('<leader>fr', "<cmd>Telescope resume<CR>", { desc = "Resume Search" })
nnoremap('<leader>fx', "<cmd>Telescope buffers show_all_buffers=true<CR>", { desc = "Telescope Buffer" })
nnoremap('<leader>fh', "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help Tags" })
nnoremap('<leader>fm', "<cmd>Telescope harpoon marks<CR>", { desc = "Telescope Harpoon Marks" })
nnoremap('<leader>fc', "<cmd>Telescope commands<CR>", { desc = "Telescope Commands" })
nnoremap('<leader>fd', "<cmd>Telescope diagnostics<CR>", { desc = "Telescope Diagostics" })
nnoremap('<leader>fk', "<cmd>Telescope keymaps<CR>", { desc = "Telescope Keymaps" })
nnoremap('<leader>fs', "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Telescope Document Symbols" })
nnoremap('<leader>fS', "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Telescope Dynamic Workspace Symbols" })

-- Buffers mappings
nnoremap('<leader>bn', "<cmd>enew<CR>", { desc = 'New buffer' })
nnoremap('<leader>ba', "<cmd>bufdo Bwipeout<CR>", { desc = 'Close all buffers' })
nnoremap('<leader>br', "<cmd>BufferLineCloseRight<CR>", { desc = 'Close buffers to the right' })
nnoremap('<leader>bl', "<cmd>BufferLineCloseLeft<CR>", { desc = 'Close buffers to the left' })
nnoremap('<leader>bo', "<cmd>%Bdelete|e#|Bdelete#<CR>|'<CR>", { desc = 'Close other buffers' })
nnoremap('<leader>bO', "<cmd>%Bdelete!|e#|Bdelete#<CR>|'<CR>", { desc = 'Close other buffers without save' })

-- Git mappings
nnoremap('<leader>gg', "<cmd>LazyGit<CR>", { desc = 'LazyGit' })
nnoremap('<leader>gL', "<cmd>LazyGitFilter<CR>", { desc = "LazyHistory" })
nnoremap('<leader>gy', "<cmd>LazyGitFilterCurrentFile<CR>", { desc = 'LazyHistory current file' })
nnoremap('<leader>gf', "<cmd>Git fetch --all<CR>", { desc = "Fetch all" })
nnoremap('<leader>gp', "<cmd>Git pull<CR>", { desc = 'Git pull' })
nnoremap('<leader>gP', "<cmd>Git push<CR>", { desc = 'Git push' })
nnoremap('<leader>gh', "<cmd>Gitsigns preview_hunk<CR>", { desc = 'Git preview hunk' })
nnoremap('<leader>gq', "<cmd>DiffviewClose<CR>", { desc = 'Close Diffview' })
nnoremap('<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = 'Diff with HEAD' })
nnoremap('<leader>gM', "<cmd>DiffviewOpen master<CR>", { desc = 'Diff with master' })
nnoremap('<leader>gm', "<cmd>DiffviewOpen main<CR>", { desc = 'Diff with main' })
nnoremap('<leader>gH', "<cmd>DiffviewFileHistory %<CR>", { desc = 'History current file' })
nnoremap('<leader>gb', "<cmd>Telescope git_bcommits<CR>", { desc = "Telescope Git Buffer Commits" })
nnoremap('<leader>gs', "<cmd>Telescope git_status<CR>", { desc = "Telescope Git Status" })
nnoremap('<leader>gc', "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git Commits" })

-- Harpoon mappings
nnoremap('<leader>hh', "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = 'Add Mark' })
nnoremap('<leader>hl', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = 'Toggle Quick Menu' })

-- Numbered marks
nnoremap('<leader>1', "<cmd> lua require('harpoon.ui').nav_file(1)<CR>", { desc = 'Go to Mark 1' })
nnoremap('<leader>2', "<cmd> lua require('harpoon.ui').nav_file(2)<CR>", { desc = 'Go to Mark 2' })
nnoremap('<leader>3', "<cmd> lua require('harpoon.ui').nav_file(3)<CR>", { desc = 'Go to Mark 3' })
nnoremap('<leader>4', "<cmd> lua require('harpoon.ui').nav_file(4)<CR>", { desc = 'Go to Mark 4' })
nnoremap('<leader>5', "<cmd> lua require('harpoon.ui').nav_file(5)<CR>", { desc = 'Go to Mark 5' })
nnoremap('<leader>6', "<cmd> lua require('harpoon.ui').nav_file(6)<CR>", { desc = 'Go to Mark 6' })

-- Trouble mappings
nnoremap('<leader>tt', "<cmd>TroubleToggle<CR>", { desc = 'Toggle Trouble' })
nnoremap('<leader>tw', "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = 'Workplace Diagnostics' })
nnoremap('<leader>td', "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Document Diagnostics" })
nnoremap('<leader>tl', "<cmd>TroubleToggle loclist<CR>", { desc = "Window Location List" })
nnoremap('<leader>tr', "<cmd>TroubleToggle lsp_references<CR>", { desc = "LSP References" })

-- Neotest mappings
nnoremap('<leader>Ta', "<cmd>lua require('neotest').run.attach({ suite = true })<cr>", { desc = "All suite" })
nnoremap('<leader>TA', "<cmd>lua require('neotest').run.attach()<cr>", { desc = "Attach" })
nnoremap('<leader>Tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Run File" })
nnoremap('<leader>TF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap' })<cr>", { desc = "Debug File" })
nnoremap('<leader>Tl', "<cmd>lua require('neotest').run.run_last()<cr>", { desc = "Run Last" })
nnoremap('<leader>TL', "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", { desc = "Debug Last" })
nnoremap('<leader>Tn', "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run Nearest" })
nnoremap('<leader>TN', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug Nearest" })
nnoremap('<leader>To', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = "Output" })
nnoremap('<leader>TS', "<cmd>lua require('neotest').run.stop()<cr>", { desc = "Stop" })
nnoremap('<leader>Ts', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Summary" })

-- LSP mappings
nnoremap('<leader>li', "<cmd>LspInfo<CR>", { desc = "Connected Language Servers" })
nnoremap('<leader>lf', "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<CR>", { desc = "Format file" })
nnoremap('<leader>lh', "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature Help" })
nnoremap('<leader>lw', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = "Add Workspace Folder" })
nnoremap('<leader>lW', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = "Remove Workspace Folder" })
nnoremap('<leader>lT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Type Definition" })
nnoremap('<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "References" })

-- REST Client mappings
nnoremap('<leader>Rr', "<Plug>RestNvim", { desc = "Run the request under cursor" })
nnoremap('<leader>Rp', "<Plug>RestNvimPreview", { desc = "Preview the request cURL command" })
nnoremap('<leader>Rl', "<Plug>RestNvimLast", { desc = "Re-run the last request" })

-- Focus mappings
nnoremap('<leader>zz', "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })
nnoremap('<leader>zt', "<cmd>Twilight<CR>", { desc = "Toggle Twilight" })

-- LSP inlay hints
nnoremap('<leader>lh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = "Toggle Inlay Hints" })
