-- =========================================================
-- Core Options (Rob Meijerink)
-- =========================================================
local opt = vim.opt
local g = vim.g

-- 1. General & Performance
opt.encoding = 'utf-8'
opt.history = 1000
opt.updatetime = 50    -- Faster completion and diagnostic updates
opt.redrawtime = 10000 -- Allow more time for redrawing large files
opt.timeoutlen = 850   -- Mapping wait time
opt.ttimeoutlen = 800
opt.synmaxcol = 300    -- Stop syntax highlight after 300 chars (performance)
opt.confirm = true     -- Ask for confirmation instead of erroring

-- 2. Display & UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 3
opt.signcolumn = 'yes'
opt.laststatus = 3 -- Global statusline (Single bar at the bottom)
opt.showcmd = true
opt.title = true
opt.scrolloff = 8 -- Minimal lines to keep above/below cursor
opt.mouse = 'a'
opt.cmdheight = 1
opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|
opt.errorbells = false
opt.showmatch = true      -- Show matching brackets
opt.matchtime = 2

-- 3. Search Settings
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- 4. Formatting & Indentation
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.wrap = false
opt.formatoptions = 'qnj1'
opt.backspace = 'indent,eol,start'

-- 5. Windows & Buffers
opt.splitbelow = true
opt.splitright = true
opt.hidden = true -- Buffers stay open in background
opt.list = true
opt.listchars = { tab = '▸ ', trail = '·' }
opt.showbreak = '↪'

-- 6. Folding (Treesitter integration)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- 7. Files, Backups & Undo
opt.backup = true
opt.writebackup = false
opt.swapfile = false -- Swap is usually annoying with modern SSDs
opt.undofile = true  -- Persistent undo history

local home = os.getenv('HOME')
local undo_dir = home .. '/.vim/tmp/undo//'
local backup_dir = home .. '/.vim/tmp/backup//'

-- Ensure directories exist (Nuchtere check)
for _, dir in ipairs({ undo_dir, backup_dir }) do
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, 'p')
    end
end

opt.undodir = undo_dir
opt.backupdir = backup_dir

-- 8. Command Mode (Wildmenu)
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignore =
'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'

-- 9. Globals & Filetype specific
opt.isfname:append("@-@")
opt.modelines = 0 -- Security: Disable modelines

-- Vue specific from legacy vue.lua
g.vue_pre_processors = 'detect_on_enter'

-- =========================================================
-- Optimization: Disable legacy providers
-- =========================================================

-- Disable providers to shave off startup milliseconds
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python3_provider = 0

-- Optional: If you ever NEED python for a specific plugin,
-- set the path explicitly to avoid $PATH scanning:
-- vim.g.python3_host_prog = '/usr/bin/python3'

-- Disable netrw completely to prevent legacy bugs
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- g.netrw_browse_split = 0
-- g.netrw_banner = 0
-- g.netrw_winsize = 25
