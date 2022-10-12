local custom_attach = require('robmeijerink.lsp.custom_attach')

require('lspconfig').volar.setup{
  init_options = {
    typescript = {
      serverPath = '~/.npm/lib/node_modules/typescript/lib/tsserverlib.js'
      -- Alternative location if installed as root:
      -- serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
    }
  },
  on_attach = function(client, bufnr)
    -- Only use null-ls for formatting
    -- client.server_capabilities.documentFormattingProvider = false
    -- client.server_capabilities.documentRangeFormattingProvider = false

    custom_attach(client, bufnr)
  end
}
