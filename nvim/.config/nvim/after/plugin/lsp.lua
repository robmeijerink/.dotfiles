local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local lsp = require("lsp-zero")
lsp.extend_lspconfig()

-- Setup neovim lua configuration
require('neodev').setup()
-- Turn on lsp status information
require('fidget').setup()

-- Preset enables customization of nvim-cmp settings.
-- lsp.preset('lsp-compe')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'intelephense',
        'rust_analyzer',
        'gopls',
        'ts_ls',
        'lua_ls',
        -- 'volar',
        'tailwindcss',
        'emmet_ls',
    },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    emmet_ls = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        require('lspconfig').emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'blade', 'vue' },
        })
    end,
  },
})

-- Fix Undefined global 'vim'
-- lsp.nvim_workspace()

-- local has_words_before = function()
--   unpack = unpack or table.unpack
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0
--              and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
--              == nil
-- end

-- local feedkey = function(key, mode)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end

-- Setup nvim-cmp.
local lspkind = require('lspkind')
local luasnip = require('luasnip')

-- These signs show on the left, next to the line number
-- local signs = {Error = " ", Warn = " ", Info = " ", Hint = "󰌶" }
--
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
-- end

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    }
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd [[ LspStop eslint ]]
      return
  end

  -- nnoremap('omnifunc', 'v:lua.vim.lsp.omnifunc')
  nnoremap("gd", function() vim.lsp.buf.definition() end, opts)
  nnoremap("gr", require('telescope.builtin').lsp_references, opts)
  nnoremap('gD', function() vim.lsp.buf.declaration() end, opts)
  nnoremap('gT', function() vim.lsp.buf.type_definition() end, opts)
  nnoremap('gi', function() vim.lsp.buf.implementation() end, opts)
  nnoremap("K", function() vim.lsp.buf.hover() end, opts)
  nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol("") end, opts)
  nnoremap("<leader>vd", function() vim.diagnostic.open_float() end, opts)
  nnoremap("[d", function() vim.diagnostic.goto_next() end, opts)
  nnoremap("]d", function() vim.diagnostic.goto_prev() end, opts)
  nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
      filter = function(code_action)
        if not code_action or not code_action.data then
          return false
        end

        local data = code_action.data.id
        return string.sub(data, #data - 1, #data) == ":0"
      end,
      apply = true
    })
  end, opts)
  nnoremap("<leader>rr", function() vim.lsp.buf.references() end, opts)
  nnoremap("<leader>rn", function() vim.lsp.buf.rename() end, opts)
  inoremap("<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- nnoremap('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- nnoremap('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- nnoremap('<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- nnoremap('<leader>fs', require('telescope.builtin').lsp_document_symbols, opts)
  -- nnoremap('<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)

  -- You will likely want to reduce updatetime which affects CursorHold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      })
    end
  })
end)

-- require('lspconfig').lua_ls.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

-- jose-elias-alvarez/null-ls.nvim
-- local null_ls = require('null-ls')
-- local null_opts = lsp.build_options('null-ls', {})
-- local utils = require('null-ls.utils')
--
-- local formatting = null_ls.builtins.formatting

-- null_ls.setup({
--   -- debug = true,
--   debounce = 150,
--   root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
--   diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
--   sources = {
--     null_ls.builtins.code_actions.gitsigns,
--     null_ls.builtins.completion.spell, -- You still need to execute `:set spell`
--     null_ls.builtins.diagnostics.psalm.with({ -- PHP Static analyzer
--       prefer_local = "vendor/bin",
--       method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
--     }),
--     -- require("null-ls").builtins.diagnostics.phpstan,
--     null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
--       prefer_local = "vendor/bin",
--       method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
--     }),
--     -- null_ls.builtins.formatting.stylua,       -- You need to install stylua first: `brew install stylua`
--     formatting.phpcbf.with({ -- Use the local installation first
--       prefer_local = "vendor/bin",
--     }),
--     formatting.pint.with({
--       prefer_local = "vendor/bin",
--     }),
--     formatting.blade_formatter,
--     -- null_ls.builtins.diagnostics.eslint,    -- Add eslint to js projects
--     formatting.prettier.with({
--       extra_args = {
--         "--no-semi",
--         "--single-quote",
--         "--jsx-single-quote",
--       }
--     }),
--     formatting.black,
--     formatting.gofmt,
--     formatting.shfmt,
--     formatting.jq,
--     formatting.rustywind,
--     formatting.clang_format, formatting.cmake_format,
--     formatting.dart_format,
--     formatting.lua_format.with({
--       extra_args = {
--         '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
--         '--break-after-table-lb', '--indent-width=2'
--       }
--     }), formatting.isort, formatting.codespell.with({ filetypes = { 'markdown' } })
--   },
--   on_attach = function(client, bufnr)
--     null_opts.on_attach(client, bufnr)
--     --- you can add other stuff here....
--   end,
-- })

-- Setup LSP
-- lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
    float = {
        source = true,
    }
})

-- Configure nvim-cmp
local cmp = require('cmp')

local source_mapping = {
    copilot = "[Copilot]",
    luasnip = "[Snippet]",
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
    max_lines = 1200,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})

vim.opt.completeopt = 'menu,menuone,noinsert,noselect'
-- vim.g.completeopt = 'menu,menuone,noinsert,noselect'

-- Needed for friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

luasnip.config.setup {}

local cmp_action = require('lsp-zero').cmp_action()

local cmp_setup = {
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-q>'] = cmp.mapping.close(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
     ["<CR>"] = cmp.mapping({
       i = function(fallback)
         if cmp.visible() and cmp.get_active_entry() then
           cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
         else
           fallback()
         end
       end,
       s = cmp.mapping.confirm({ select = true }),
       c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
     }),

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif has_words_before() then
      --   cmp.complete()
      --   if #cmp.get_entries() == 1 then
      --     cmp.confirm({ select = true })
      --   end
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      -- elseif has_words_before() then
      --   cmp.complete()
      --   if #cmp.get_entries() == 1 then
      --     cmp.confirm({ select = true })
      --   end
      else
        fallback()
      end
    end, {"i", "s"})
  },
  sources = cmp.config.sources({
    -- {name = 'vsnip'}, -- For vsnip user.
    -- For ultisnips user.
    -- { name = 'ultisnips' },
        { name = 'copilot' },
        { name = 'luasnip' }, -- For luasnip user.
        { name = 'nvim_lsp' },
        { name = 'cmp_tabnine' },
        { name = "nvim_lsp_signature_help" },
        { name = 'buffer', keyword_length = 3 },
        { name = "path", keyword_length = 2 },
  }),
  formatting = {
    -- format = lspkind.cmp_format({
    --   with_text = true,
    --   maxwidth = 50,
    -- }),
    format = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        local menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                menu = entry.completion_item.data.detail .. " " .. menu
            end
            vim_item.kind = ""
        end
        if entry.source.name == "copilot" then
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                menu = entry.completion_item.data.detail .. " " .. menu
            end
            vim_item.kind = ""
        end
        vim_item.menu = menu
        return vim_item
    end,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
    experimental = {
        ghost_text = true,
    },
}

-- Setup cmp
cmp.setup(cmp_setup)
