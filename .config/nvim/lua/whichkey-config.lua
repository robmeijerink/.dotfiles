local wk = require("which-key")
wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {enabled = false, suggestions = 20},
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
local toggle_float = function()
  local float = Terminal:new({direction = "float"})
  return float:toggle()
end
local toggle_lazygit = function()
  local lazygit = Terminal:new({cmd = 'lazygit', direction = "float"})
  return lazygit:toggle()
end

local mappings = {
  q = {"<cmd>q<CR>", "Quit"},
  Q = {"<cmd>wq<CR>", "Save & Quit"},
  w = {"<cmd>w<CR>", "Save"},
  x = {"<cmd>bdelete<CR>", "Close"},
  X = {"<cmd>bdelete!<CR>", "Close"},
  E = {"<cmd>e ~/.config/nvim/init.lua<CR>", "Edit config"},
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", "Telescope Find Files"},
    g = { "<cmd>Telescope live_grep hidden=true no_ignore=true<CR>", "Telescope Live Grep"},
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File"},
    x = { "<cmd>Telescope buffers show_all_buffers=true<CR>", "Telescope Buffer"},
    h = { "<cmd>Telescope help_tags<CR>", "Telescope Help Tags" },
    m = { "<cmd>Telescope harpoon marks<CR>", "Telescope Harpoon Marks" },
    c = { "<cmd>Telescope commands<CR>", "Telescope Commands" },
    s = { "<cmd>Telescope git_status<CR>", "Telescope Git Status" },
    a = { "<cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
    q = { "<cmd>Telescope git_bcommits<CR>", "Telescope Git Buffer Commits" },
  },
  b = {
    name = "Buffers",
    n = {"<cmd>enew<CR>", 'New buffer'},
    r = {"<cmd>BufferLineCloseRight<CR>", 'Close buffers to the right'},
    l = {"<cmd>BufferLineCloseLeft<CR>", 'Close buffers to the left'},
    o = {"<cmd>%bd|e#<CR>", 'Close other buffers'},
    O = {'<cmd>%bd!|e#"<CR>', 'Close other buffers without save'}
  },
  t = {
    name = "Tabs",
    n = {"<cmd>tabnew<CR>", 'New tab'},
    c = {"<cmd>tabclose<CR>", 'Close tab'},
    o = {"<cmd>tabonly<CR>", 'Close other tabs'}
  },
  T = {
    name = "UI Terminal",
    t = {"<cmd>ToggleTerm<CR>", "Split Below"},
    f = {toggle_float, "Floating Terminal"},
    l = {toggle_lazygit, "LazyGit"}
  },
  h = {
    name = "Harpoon",
    l = {  "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", 'Toggle Quick Menu' },
    a =  { "<cmd>lua require('harpoon.mark').add_file()<CR>", 'Add Mark' },
  },
  l = {
    name = "LSP",
    i = {"<cmd>LspInfo<CR>", "Connected Language Servers"},
    k = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help"},
    K = {"<cmd>Lspsaga hover_doc<CR>", "Hover Commands"},
    w = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add Workspace Folder"},
    W = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove Workspace Folder"},
    l = {
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      "List Workspace Folders"
    },
    t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type Definition"},
    d = {'<cmd>lua vim.lsp.buf.definition()<CR>', "Go To Definition"},
    D = {'<cmd>lua vim.lsp.buf.declaration()<CR>', "Go To Declaration"},
    r = {'<cmd>lua vim.lsp.buf.references()<CR>', "References"},
    R = {'<cmd>Lspsaga rename<CR>', "Rename"},
    a = {'<cmd>Lspsaga code_action<CR>', "Code Action"},
    e = {'<cmd>Lspsaga show_line_diagnostics<CR>', "Show Line Diagnostics"},
    n = {'<cmd>Lspsaga diagnostic_jump_next<CR>', "Go To Next Diagnostic"},
    N = {'<cmd>Lspsaga diagnostic_jump_prev<CR>', "Go To Previous Diagnostic"}
  },
  z = {
    name = "Focus",
    z = {"<cmd>ZenMode<CR>", "Toggle Zen Mode"},
    t = {"<cmd>Twilight<CR>", "Toggle Twilight"}
  }
}

local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
