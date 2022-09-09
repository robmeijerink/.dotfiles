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
  W = { "<cmd>set wrap!<CR><CR>", "Toggle line wrapping" },
  p = { ':set paste<CR>"*p:set nopaste<CR>', "Paste in Paste Mode" },
  x = { "<cmd>Bdelete<CR>", "Close" },
  X = { "<cmd>Bdelete!<CR>", "Close" },
  E = { "<cmd>e ~/.config/nvim/init.lua<CR>", "Edit config" },
  f = {
    name = "Find",
    t = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", 'Find and open in tmux' },
    f = { "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", "Telescope Find Files" },
    g = { "<cmd>Telescope live_grep hidden=true no_ignore=true<CR>", "Telescope Live Grep" },
    w = { "<cmd>Telescope grep_string<CR>", "Telescope Grep Word" },
    o = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    r = { "<cmd>Telescope resume<CR>", "Resume Search" },
    x = { "<cmd>Telescope buffers show_all_buffers=true<CR>", "Telescope Buffer" },
    h = { "<cmd>Telescope help_tags<CR>", "Telescope Help Tags" },
    m = { "<cmd>Telescope harpoon marks<CR>", "Telescope Harpoon Marks" },
    c = { "<cmd>Telescope commands<CR>", "Telescope Commands" },
    s = { "<cmd>Telescope git_status<CR>", "Telescope Git Status" },
    a = { "<cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
    q = { "<cmd>Telescope git_bcommits<CR>", "Telescope Git Buffer Commits" },
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
  t = {
    name = "Tabs",
    n = { "<cmd>tabnew<CR>", 'New tab' },
    c = { "<cmd>tabclose<CR>", 'Close tab' },
    o = { "<cmd>tabonly<CR>", 'Close other tabs' }
  },
  g = {
    name = "Git",
    l = { toggle_lazygit, "LazyGit" },
    a = { "<cmd>!git fetch --all<CR>", "Fetch all" },
    g = { "<cmd>Neogit<CR>", 'Neogit' },
    d = { "<cmd>DiffviewOpen<CR>", 'Diff with HEAD' },
    D = { "<cmd>DiffviewOpen master<CR>", 'Diff with master' },
    h = { "<cmd>DiffviewFileHistory %<CR>", 'History current file' },
    L = { "<cmd>Neogit log<CR>", 'Neogit log' },
    p = { "<cmd>Neogit pull<CR>", 'Neogit pull' },
    P = { "<cmd>Neogit push<CR>", 'Neogit push' },
    c = { "<cmd>Neogit commit<CR>", 'Neogit commit' },
  },
  h = {
    name = "Harpoon",
    l = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", 'Toggle Quick Menu' },
    a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", 'Add Mark' },
    q = { "<cmd> lua require('harpoon.ui').nav_file(1)<CR>", 'Go to Mark 1' },
    w = { "<cmd> lua require('harpoon.ui').nav_file(2)<CR>", 'Go to Mark 2' },
    e = { "<cmd> lua require('harpoon.ui').nav_file(3)<CR>", 'Go to Mark 3' },
    r = { "<cmd> lua require('harpoon.ui').nav_file(4)<CR>", 'Go to Mark 4' },
    t = { "<cmd> lua require('harpoon.ui').nav_file(5)<CR>", 'Go to Mark 5' },
    y = { "<cmd> lua require('harpoon.ui').nav_file(6)<CR>", 'Go to Mark 6' },
  },
  T = {
    name = "Trouble",
    t = { "<cmd>TroubleToggle<CR>", 'Toggle Trouble' },
    w = { "<cmd>TroubleToggle workspace_diagnostics<CR>", 'Workplace Diagnostics' },
    d = { "<cmd>TroubleToggle document_diagnostics<CR>", "Document Diagnostics" },
    l = { "<cmd>TroubleToggle loclist<CR>", "Window Location List" },
    d = { "<cmd>TroubleToggle lsp_references<CR>", "LSP References" },
  },
  l = {
    name = "LSP",
    i = { "<cmd>LspInfo<CR>", "Connected Language Servers" },
    f = { "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", "Format file" },
    h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    k = { "<cmd>Lspsaga hover_doc<CR>", "Hover Commands" },
    w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add Workspace Folder" },
    W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove Workspace Folder" },
    l = {
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      "List Workspace Folders"
    },
    t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type Definition" },
    d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Go To Definition" },
    D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "Go To Declaration" },
    r = { '<cmd>lua vim.lsp.buf.references()<CR>', "References" },
    R = { '<cmd>Lspsaga rename<CR>', "Rename" },
    a = { '<cmd>Lspsaga code_action<CR>', "Code Action" },
    e = { '<cmd>Lspsaga show_line_diagnostics<CR>', "Show Line Diagnostics" },
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
