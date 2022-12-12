local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Enable the following language servers
local servers = {
  'intelephense',
  'rust_analyzer',
  'tsserver',
  'sumneko_lua',
  'volar',
  'tailwindcss',
  'emmet_ls',
}

-- Ensure the servers above are installed
require('nvim-lsp-installer').setup {
  ensure_installed = servers,
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

-- for _, lsp in ipairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

local custom_on_attach = function(client, bufnr)
  local opts = { buffer = true };
  -- nnoremap('omnifunc', 'v:lua.vim.lsp.omnifunc')
  nnoremap("gd", function() vim.lsp.buf.definition() end, opts)
  nnoremap('gD', function() vim.lsp.buf.declaration() end, opts)
  nnoremap('gT', function() vim.lsp.buf.type_definition() end, opts)
  nnoremap('gi', function() vim.lsp.buf.implementation() end, opts)
  nnoremap("K", function() vim.lsp.buf.hover() end, opts)
  nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  nnoremap("<leader>vd", function() vim.diagnostic.open_float() end, opts)
  nnoremap("[d", function() vim.diagnostic.goto_next() end, opts)
  nnoremap("]d", function() vim.diagnostic.goto_prev() end, opts)
  nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
      filter = function(code_action)
        if not code_action or not code_action.data then
          return false
        end

        local data = code_action.data.id
        return string.sub(data, #data - 1, #data) == ":0"
      end,
      apply = true
    })
  end, opts)
  nnoremap("<leader>vrr", function() vim.lsp.buf.references() end, opts)
  nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  inoremap("<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- nnoremap('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- nnoremap('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- nnoremap('<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = custom_on_attach,
  }, _config or {})
end

-- LSP Configurations.

lspconfig.sumneko_lua.setup(config({
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
      telemetry = { enable = false }
    }
  }
}))

require("lspconfig").gopls.setup(config({
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}))

require('lspconfig')['rust_analyzer'].setup(config({
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}))

require('lspconfig').intelephense.setup(config({
  -- on_attach = function(client, bufnr)
  -- Only use null-ls for formatting
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  -- end,
  filetypes = { 'html', 'blade', 'php' },
  flags = {
    debounce_text_changes = 150
  }
}))

lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  -- filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'php', 'sass', 'scss', 'less', 'blade', 'vue' },
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'blade', 'vue' },
})

require('lspconfig').tailwindcss.setup({
  capabilities = capabilities,
})

lspconfig.tsserver.setup(config({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)
    custom_on_attach(client, bufnr)
  end,
}))

require('lspconfig').volar.setup {
  init_options = {
    typescript = {
      serverPath = '~/.npm/lib/node_modules/typescript/lib/tsserverlib.js'
      -- Alternative location if installed as root:
      -- serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
    }
  },
  -- on_attach = function(client, bufnr)
  -- Only use null-ls for formatting
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  -- end
}
