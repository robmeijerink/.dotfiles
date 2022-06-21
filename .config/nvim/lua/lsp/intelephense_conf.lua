require('lspconfig').intelephense.setup({
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true }
      
      -- Enable (omnifunc) completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      -- Here we should add additional keymaps and configuration options.
    end,
    flags = {
      debounce_text_changes = 150
    }
})
