local custom_attach = require('robmeijerink.lsp.custom_attach')

require('lspconfig').intelephense.setup({
    on_attach = function(client, bufnr)
      -- Only use null-ls for formatting
      -- client.server_capabilities.documentFormattingProvider = false
      -- client.server_capabilities.documentRangeFormattingProvider = false
      custom_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150
    }
})
