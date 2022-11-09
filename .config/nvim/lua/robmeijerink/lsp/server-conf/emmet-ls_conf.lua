local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    -- filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'php', 'sass', 'scss', 'less', 'blade', 'vue' },
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'blade', 'vue' },
})
