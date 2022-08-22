local null_ls = require('null-ls')
local utils = require('null-ls.utils')

local formatting = null_ls.builtins.formatting

null_ls.setup({
  root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
  diagnostics_format = "#{m} (#{c}) [#{s}]",    -- Makes PHPCS errors more readeable
  sources = {
    null_ls.builtins.completion.spell,        -- You still need to execute `:set spell`
    -- null_ls.builtins.diagnostics.eslint,      -- Add eslint to js projects
    null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
       prefer_local = "vendor/bin",
    }),
    -- null_ls.builtins.formatting.stylua,       -- You need to install stylua first: `brew install stylua`
    null_ls.builtins.formatting.phpcbf.with({ -- Use the local installation first
        prefer_local = "vendor/bin",
    }),
    formatting.prettier,
    formatting.black,
    formatting.gofmt,
    formatting.shfmt,
    formatting.clang_format, formatting.cmake_format,
    formatting.dart_format,
    formatting.lua_format.with({
      extra_args = {
        '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
        '--break-after-table-lb', '--indent-width=2'
      }
    }), formatting.isort, formatting.codespell.with({filetypes = {'markdown'}})
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
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
})
