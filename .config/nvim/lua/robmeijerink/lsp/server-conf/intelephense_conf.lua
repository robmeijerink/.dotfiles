local custom_attach = require('robmeijerink.lsp.custom_attach')

require('lspconfig').intelephense.setup({
    on_attach = function(client, bufnr)
      custom_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150
    }
})
