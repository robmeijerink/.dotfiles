local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- vim.lsp.buf.formatting_sync()
              vim.lsp.buf.formatting_seq_sync()
          end,
      })
  end
--   if client.resolved_capabilities.document_formatting then
--     vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
--   end
  if client.resolved_capabilities.document_highlight then
      vim.cmd [[
          augroup document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
          augroup END
        ]]
  end
end
