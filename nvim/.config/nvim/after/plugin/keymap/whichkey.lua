local wk = require("which-key")
wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = false, suggestions = 20 },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true
    }
  }
}

local Terminal = require('toggleterm.terminal').Terminal
local toggle_lazygit = function()
  local lazygit = Terminal:new({ cmd = 'lazygit', direction = "float" })
  return lazygit:toggle()
end

local mappings = {
  w = { "<cmd>w<CR>", "Save" },
  -- W = { "<cmd>set wrap!<CR><CR>", "Toggle line wrapping" }, -- Duplicate mapping use [ow and ]ow instead
  p = { ':set paste<CR>"*p:set nopaste<CR>', "Paste in Paste Mode" },
  x = { "<cmd>Bdelete<CR>", "Close" },
  X = { "<cmd>Bdelete!<CR>", "Close" },
  f = {
    name = "Find",
    t = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", 'Find and open in tmux' },
    f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    a = { "<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, hidden = true, prompt_title = 'All Files' })<CR>", "All Files" },
    -- G = { "<cmd>Telescope live_grep hidden=true no_ignore=false<CR>", "Telescope Live Grep" },
    G = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Telescope Live Grep (args)" },
    g = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ') })<CR>", "Telescope Live Grep in Word" },
    w = { "<cmd>Telescope grep_string<CR>", "Telescope Grep Word" },
    v = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>", "Find word under cursor" },
    o = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    r = { "<cmd>Telescope resume<CR>", "Resume Search" },
    x = { "<cmd>Telescope buffers show_all_buffers=true<CR>", "Telescope Buffer" },
    h = { "<cmd>Telescope help_tags<CR>", "Telescope Help Tags" },
    m = { "<cmd>Telescope harpoon marks<CR>", "Telescope Harpoon Marks" },
    c = { "<cmd>Telescope commands<CR>", "Telescope Commands" },
    d = { "<cmd>Telescope diagnostics<CR>", "Telescope Diagostics" },
    k = { "<cmd>Telescope keymaps<CR>", "Telescope Keymaps" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Telescope Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Telescope Dynamic Workspace Symbols" },
  },
  b = {
    name = "Buffers",
    n = { "<cmd>enew<CR>", 'New buffer' },
    a = { "<cmd>bufdo Bwipeout<CR>", 'Close all buffers' },
    r = { "<cmd>BufferLineCloseRight<CR>", 'Close buffers to the right' },
    l = { "<cmd>BufferLineCloseLeft<CR>", 'Close buffers to the left' },
    o = { "<cmd>%Bdelete|e#|Bdelete#<CR>|'<CR>", 'Close other buffers' },
    O = { "<cmd>%Bdelete!|e#|Bdelete#<CR>|'<CR>", 'Close other buffers without save' }
  },
  -- t = {
  --   name = "Tabs",
  --   n = { "<cmd>tabnew<CR>", 'New tab' },
  --   c = { "<cmd>tabclose<CR>", 'Close tab' },
  --   o = { "<cmd>tabonly<CR>", 'Close other tabs' },
  --   a = { "<cmd>only<CR>", 'Close other tabs & windows' }
  -- },
  g = {
    name = "Git",
    g = { toggle_lazygit, "LazyGit" },
    L = { "<cmd>LazyGitFilter<CR>", "LazyHistory" },
    y = { "<cmd>LazyGitFilterCurrentFile<CR>", 'LazyHistory current file' },
    -- Git fugitive
    f = { "<cmd>Git fetch --all<CR>", "Fetch all" },
    p = { "<cmd>Git pull<CR>", 'Git pull' },
    P = { "<cmd>Git push<CR>", 'Git push' },
    h = { "<cmd>Gitsigns preview_hunk<CR>", 'Git preview hunk' },
    q = { "<cmd>DiffviewClose<CR>", 'Close Diffview' },
    d = { "<cmd>DiffviewOpen<CR>", 'Diff with HEAD' },
    D = { "<cmd>DiffviewOpen master<CR>", 'Diff with master' },
    H = { "<cmd>DiffviewFileHistory %<CR>", 'History current file' },
    b = { "<cmd>Telescope git_bcommits<CR>", "Telescope Git Buffer Commits" },
    s = { "<cmd>Telescope git_status<CR>", "Telescope Git Status" },
    c = { "<cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
    -- g = { "<cmd>Neogit<CR>", 'Neogit' },
    -- o = { "<cmd>Neogit log<CR>", 'Neogit log' },
    -- p = { "<cmd>Neogit pull<CR>", 'Neogit pull' },
    -- P = { "<cmd>Neogit push<CR>", 'Neogit push' },
    -- c = { "<cmd>Neogit commit<CR>", 'Neogit commit' },
  },
  h = {
    name = "Harpoon",
    h = { "<cmd>lua require('harpoon.mark').add_file()<CR>", 'Add Mark' },
    l = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", 'Toggle Quick Menu' },
  },
  ["1"] = { "<cmd> lua require('harpoon.ui').nav_file(1)<CR>", 'Go to Mark 1' },
  ["2"] = { "<cmd> lua require('harpoon.ui').nav_file(2)<CR>", 'Go to Mark 2' },
  ["3"] = { "<cmd> lua require('harpoon.ui').nav_file(3)<CR>", 'Go to Mark 3' },
  ["4"] = { "<cmd> lua require('harpoon.ui').nav_file(4)<CR>", 'Go to Mark 4' },
  ["5"] = { "<cmd> lua require('harpoon.ui').nav_file(5)<CR>", 'Go to Mark 5' },
  ["6"] = { "<cmd> lua require('harpoon.ui').nav_file(6)<CR>", 'Go to Mark 6' },
  t = {
    name = "Trouble",
    t = { "<cmd>TroubleToggle<CR>", 'Toggle Trouble' },
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", 'Workplace Diagnostics' },
    d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Document Diagnostics" },
    l = { "<cmd>TroubleToggle loclist<CR>", "Window Location List" },
    r = { "<cmd>TroubleToggle lsp_references<CR>", "LSP References" },
  },
  T = {
    name = "Neotest",
    a = { "<cmd>lua require('neotest').run.attach({ suite = true })<cr>", "All suite" },
    A = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
    f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
    F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
    l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
    L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
    n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
    N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
    o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
    S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
    s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
  },
  l = {
    name = "LSP",
    i = { "<cmd>LspInfo<CR>", "Connected Language Servers" },
    f = { "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<CR>", "Format file" },
    h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    k = { "<cmd>Lspsaga hover_doc<CR>", "Hover Commands" },
    w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add Workspace Folder" },
    W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove Workspace Folder" },
    -- l = {
    --   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    --   "List Workspace Folders"
    -- },
    T = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type Definition" },
    -- d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Go To Definition" },
    -- D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "Go To Declaration" },
    r = { '<cmd>lua vim.lsp.buf.references()<CR>', "References" },
    R = { '<cmd>Lspsaga rename<CR>', "Rename" },
    a = { '<cmd>Lspsaga code_action<CR>', "Code Action" },
    d = { '<cmd>Lspsaga show_line_diagnostics<CR>', "Show Line Diagnostics" },
    n = { '<cmd>Lspsaga diagnostic_jump_next<CR>', "Go To Next Diagnostic" },
    N = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', "Go To Previous Diagnostic" }
  },
  R = {
    name = "REST Client",
    r = { "<Plug>RestNvim", "Run the request under cursor" },
    p = { "<Plug>RestNvimPreview", "Preview the request cURL command" },
    l = { "<Plug>RestNvimLast", "Re-run the last request" },
  },
  z = {
    name = "Focus",
    z = { "<cmd>ZenMode<CR>", "Toggle Zen Mode" },
    t = { "<cmd>Twilight<CR>", "Toggle Twilight" }
  }
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
