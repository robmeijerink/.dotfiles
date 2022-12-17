local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'intelephense',
  'rust_analyzer',
  'tsserver',
  'sumneko_lua',
  'volar',
  'tailwindcss',
  'emmet_ls',
})

-- hrsh7th/nvim-cmp
vim.g.completeopt = "menu,menuone,noselect,noinsert"
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
             and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
             == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require('lspkind')
local luasnip = require('luasnip')

local source_mapping = {
  luasnip = "[Snippet]",
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

local cmp_setup = {
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-q>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif vim.fn["vsnip#available"]() == 1 then
      --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      --   feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, {"i", "s"})
  },
  sources = cmp.config.sources({
    -- {name = 'vsnip'}, -- For vsnip user.
    -- For ultisnips user.
    -- { name = 'ultisnips' },
    { name = 'luasnip' }, -- For luasnip user.
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
    { name = "nvim_lsp_signature_help" },
    { name = 'buffer' },
    { name = "path" },
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
        vim_item.menu = menu
        return vim_item
    end,
  }
}

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1200,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

lsp.setup_nvim_cmp(cmp_setup)

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = " ",
        warn = " ",
        hint = " ",
        info = " "
    }
})

vim.diagnostic.config({
    virtual_text = true,
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd [[ LspStop eslint ]]
      return
  end

  -- nnoremap('omnifunc', 'v:lua.vim.lsp.omnifunc')
  nnoremap("gd", function() vim.lsp.buf.definition() end, opts)
  nnoremap('gD', function() vim.lsp.buf.declaration() end, opts)
  nnoremap('gT', function() vim.lsp.buf.type_definition() end, opts)
  nnoremap('gi', function() vim.lsp.buf.implementation() end, opts)
  nnoremap("K", function() vim.lsp.buf.hover() end, opts)
  nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
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
  nnoremap("<leader>vrr", function() vim.lsp.buf.references() end, opts)
  nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  inoremap("<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- nnoremap('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- nnoremap('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- nnoremap('<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end)

lsp.configure('emmet_ls', {
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'blade', 'vue' },
})

lsp.setup()