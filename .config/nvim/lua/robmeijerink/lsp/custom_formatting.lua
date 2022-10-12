-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return function(client, bufnr)
    -- if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = function()
    --             vim.lsp.buf.format({ bufnr = bufnr })
    --         end,
    --     })
    -- end
    --   if client.resolved_capabilities.documentFormattingProvider then
    --     vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
    --   end
    -- if client.resolved_capabilities.document_highlight then
    --     vim.cmd [[
    --       augroup document_highlight
    --         autocmd! * <buffer>
    --         autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
    --         autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
    --       augroup END
    --     ]]
    -- end
end
