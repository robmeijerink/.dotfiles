local custom_attach = require('robmeijerink.lsp.custom_attach')

require('lspconfig').intelephense.setup({
    on_attach = custom_attach,
    flags = {
      debounce_text_changes = 150
    }
})