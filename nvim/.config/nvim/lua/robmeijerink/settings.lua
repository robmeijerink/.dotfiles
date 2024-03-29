HOME = os.getenv('HOME')

-- basic settings
vim.opt.encoding = 'utf-8'
vim.opt.backspace = 'indent,eol,start' -- backspace works on every char in insert mode
vim.opt.completeopt = 'menuone,noselect,longest,preview'
vim.opt.history = 1000
vim.opt.dictionary = '/usr/share/dict/words'
vim.opt.startofline = true
vim.opt.exrc = false -- vim will look for and use a local .vimrc file

-- Mapping waiting time
vim.opt.timeout = true
vim.opt.timeoutlen = 850
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 800

-- Display
vim.opt.showmatch  = true -- show matching brackets
vim.opt.scrolloff = 3 -- always show 3 rows from edge of the screen
vim.opt.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.opt.laststatus = 2 -- always show status line
vim.opt.hidden = true -- enable background buffers / windows

vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- vim.opt.foldenable = false
-- vim.opt.foldlevel = 4 -- limit folding to 4 levels
-- vim.opt.foldmethod = 'syntax' -- use language syntax to generate folds
-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.wrap = false --do not wrap lines even if very long
vim.opt.eol = false -- show if there's no eol char
vim.opt.showbreak= '↪' -- character to show when line is broken
vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Sidebar
vim.opt.number = true -- line number on the left
vim.opt.relativenumber = true -- Use relative line numbers
vim.opt.numberwidth = 3 -- always reserve 3 spaces for line number
vim.opt.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.opt.modelines = 0
vim.opt.showcmd = true -- display command in bottom bar

-- Search
vim.opt.incsearch = true -- starts searching as soon as typing, without enter needed
vim.opt.ignorecase = true -- ignore letter case when searching
vim.opt.smartcase = true -- case insentive unless capitals used in search
vim.opt.hlsearch = true -- turns the highlighting back on when you start a new search and off after search

vim.opt.matchtime = 2 -- delay before showing matching paren

-- Global Status Bar
vim.opt.laststatus = 3

vim.opt.title = true -- Show more info in the bottom left

-- Enable mouse wheel scrolling
vim.opt.mouse = 'a'

-- White characters
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4 -- 1 tab = 4 spaces
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- indentation rule
vim.opt.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
vim.opt.expandtab = true -- expand tab to spaces

-- Backup files
vim.opt.backup = true -- use backup files
vim.opt.writebackup = false
vim.opt.swapfile = false -- do not use swap file
vim.opt.undofile = true -- Save undo history
vim.opt.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.opt.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.opt.directory = '/.vim/tmp/swap//'           -- swap files

-- Decrease update time
-- -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- -- delays and poor user experience.
vim.opt.updatetime = 50
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- -- Give more space for displaying messages.
vim.opt.cmdheight = 1

vim.opt.errorbells = false

-- -- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

vim.opt.wildmode = 'longest:full,full' -- complete the longest common match, and allow tabbing the results to fully complete them

-- Allow long redrawtime for opening large files.
vim.opt.redrawtime = 10000

-- Ask for confirmation instead of erroring.
vim.opt.confirm = true

vim.cmd([[
  au FileType python                  set ts=4 sw=4
  au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.ppmd        set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.slimbars    set syntax=slim
]])

-- Commands mode
vim.opt.wildmenu = true -- on TAB, complete options for system command
vim.opt.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'

-- WSL Only Settings
-- if (string.find(vim.loop.os_uname().release, 'WSL')) then

    -- Changed this snippet to use win32yank instead of xclip

    -- Fixes copy to clipboard in Windows WSL2
    -- vim.opt.clipboard = 'unnamed'
  -- vim.opt.clipboard = "unnamedplus"

  -- vim.api.nvim_create_autocmd('TextYankPost', {
  --     group = vim.api.nvim_create_augroup('Yank', { clear = true }),
  --
  --     callback = function()
  --         vim.fn.system('clip.exe', vim.fn.getreg('"'))
  --     end,
  -- })
-- end

-- Only show cursorline in the current window and in normal mode.
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

vim.cmd([[
    augroup blade
    autocmd!
    au FileType blade set ts=4 sw=4
    autocmd BufNewFile,BufRead *.blade.php set filetype=blade
    augroup END
]])

local augroup = vim.api.nvim_create_augroup
local RobMeijerinkGroup = augroup('RobMeijerinkGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

-- Hightlight the text when yanking
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove whitespace on saving a file
autocmd({"BufWritePre"}, {
    group = RobMeijerinkGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Auto-command to open a file on the last position on which the file has closed.
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Indent with tabs in Makefiles
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"Makefile","*.make"}, -- Specify the file pattern for Makefiles
  callback = function()
    vim.opt_local.expandtab = false -- Set local option to use tab characters
  end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
