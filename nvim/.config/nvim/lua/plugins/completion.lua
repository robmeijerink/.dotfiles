-- =========================================================
-- Plugin: Completion Stack (Rob Meijerink Architecture)
-- =========================================================
return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        { 'L3MON4D3/LuaSnip', build = "make install_jsregexp", dependencies = { 'rafamadriz/friendly-snippets' } },
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'onsails/lspkind.nvim',
        { 'tzachar/cmp-tabnine', build = './install.sh' },
        { "zbirenbaum/copilot-cmp", dependencies = { "zbirenbaum/copilot.lua" }, config = function() require("copilot_cmp").setup() end },
    },
    config = function()
        local cmp = require('cmp')
        local ls = require('luasnip')
        local lspkind = require('lspkind')

        -- 1. AI Configuration (Tabnine)
        require("cmp_tabnine.config"):setup({
            max_lines = 1200,
            max_num_results = 20,
            sort = true,
            run_on_every_keystroke = true,
        })

        -- 2. Main Completion Setup
        cmp.setup({
            preselect = 'none',
            completion = { completeopt = 'menu,menuone,noinsert,noselect' },
            snippet = { expand = function(args) ls.lsp_expand(args.body) end },

            -- Mapping logic from your lsp.lua
            mapping = cmp.mapping.preset.insert({
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_next_item()
                    elseif ls.expand_or_jumpable() then ls.expand_or_jump()
                    else fallback() end
                end, { "i", "s" }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_prev_item()
                    elseif ls.jumpable(-1) then ls.jump(-1)
                    else fallback() end
                end, { "i", "s" }),
            }),

            -- Source and Formatting logic (Using your specific source_mapping)
            sources = cmp.config.sources({
                { name = 'copilot' },
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'cmp_tabnine' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'buffer', keyword_length = 3 },
                { name = 'path' },
            }),

            formatting = {
                format = function(entry, vim_item)
                    local source_mapping = {
                        copilot = "[Copilot]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[Lua]",
                        cmp_tabnine = "[TN]",
                        path = "[Path]",
                    }
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    local menu = source_mapping[entry.source.name]
                    if entry.source.name == "cmp_tabnine" then vim_item.kind = "" end
                    if entry.source.name == "copilot" then vim_item.kind = "" end
                    vim_item.menu = menu
                    return vim_item
                end,
            },

            sorting = {
                priority_weight = 2,
                comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            experimental = { ghost_text = true },
        })
    end
}
