local null_ls = require('null-ls')
local utils = require('null-ls.utils')

local formatting = null_ls.builtins.formatting

null_ls.setup({
  -- debug = true,
  debounce = 150,
  root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
  diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
  sources = {
    null_ls.builtins.completion.spell, -- You still need to execute `:set spell`
    -- null_ls.builtins.diagnostics.eslint,      -- Add eslint to js projects
    null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
      prefer_local = "vendor/bin"
    }),
    -- null_ls.builtins.formatting.stylua,       -- You need to install stylua first: `brew install stylua`
    formatting.phpcbf.with({ -- Use the local installation first
      prefer_local = "vendor/bin"
    }),
    formatting.blade_formatter,
    formatting.prettier.with({
      extra_args = {
        "--no-semi",
        "--single-quote",
        "--jsx-single-quote",
      }
    }),
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
    }), formatting.isort, formatting.codespell.with({ filetypes = { 'markdown' } })
  },
})
