-- =========================================================
-- Plugin: LSP Suite (Rob Meijerink Architecture)
-- =========================================================
return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'folke/neodev.nvim', opts = {} }, -- Lua development helper
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
            'glepnir/lspsaga.nvim',
            'ray-x/lsp_signature.nvim',
            'onsails/lspkind.nvim',
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- 1. LSP Handlers & Diagnostics Configuration
            -- Taken from legacy twilight.lua and lsp.lua
            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = true,
                    virtual_text = { spacing = 5, severity = { min = vim.diagnostic.severity.WARN } },
                    update_in_insert = true
                }
            )

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = 'rounded',
                    source = 'always',
                    focusable = false,
                },
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN]  = "",
                    [vim.diagnostic.severity.HINT]  = "",
                    [vim.diagnostic.severity.INFO]  = "",
                }
            })

            -- 2. LSP Signature Configuration
            local signature_cfg = {
                debug = false,
                bind = true,
                doc_lines = 0,
                floating_window = false,
                hint_enable = true,
                hint_scheme = "Comment",
                hint_prefix = '',
                use_lspsaga = false,
                hi_parameter = "LspSignatureActiveParameter",
                max_height = 12,
                max_width = 120,
                handler_opts = { border = "rounded" },
                always_trigger = false,
                zindex = 200,
            }

            -- 3. LSP On Attach (Keymaps & Logic)
            lsp_zero.on_attach(function(client, bufnr)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, remap = false, desc = desc })
                end

                -- Disable eslint if other tools are preferred
                if client.name == "eslint" then
                    vim.cmd [[ LspStop eslint ]]
                    return
                end

                -- Core LSP Mappings
                map("n", "gd", function() vim.lsp.buf.definition() end, "Go to definition")
                map("n", "gr", require('telescope.builtin').lsp_references, "References (Telescope)")
                map("n", "gD", function() vim.lsp.buf.declaration() end, "Go to declaration")
                map("n", "gT", function() vim.lsp.buf.type_definition() end, "Type definition")
                map("n", "gi", function() vim.lsp.buf.implementation() end, "Implementation")
                map("n", "K", function() vim.lsp.buf.hover() end, "Hover Documentation")
                map("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol("") end, "Workspace Symbols")
                map("n", "<leader>vd", function() vim.diagnostic.open_float() end, "Line Diagnostics")
                map("n", "[d", function() vim.diagnostic.goto_next() end, "Next Diagnostic")
                map("n", "]d", function() vim.diagnostic.goto_prev() end, "Previous Diagnostic")
                map("n", "<leader>vca", function() vim.lsp.buf.code_action() end, "Code Actions")

                -- Specialized Code Action Filter (from your legacy config)
                map("n", "<leader>vco", function()
                    vim.lsp.buf.code_action({
                        filter = function(code_action)
                            if not code_action or not code_action.data then return false end
                            local data = code_action.data.id
                            return string.sub(data, #data - 1, #data) == ":0"
                        end,
                        apply = true
                    })
                end, "Code Actions (Filter :0)")

                map("n", "<leader>rr", function() vim.lsp.buf.references() end, "LSP References")
                map("n", "<leader>rn", function() vim.lsp.buf.rename() end, "Rename")
                map("i", "<C-h>", function() vim.lsp.buf.signature_help() end, "Signature Help")

                -- Initialize LSP Signature
                require("lsp_signature").on_attach(signature_cfg, bufnr)

                -- Diagnostics on CursorHold
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

            -- 4. Server Management (Mason)
            require('fidget').setup({})
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'intelephense', 'rust_analyzer', 'gopls', 'ts_ls',
                    'lua_ls', 'tailwindcss', 'emmet_ls',
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    emmet_ls = function()
                        require('lspconfig').emmet_ls.setup({
                            filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'blade', 'vue' },
                        })
                    end,
                },
            })

            -- 5. LSPSaga Setup
            require('lspsaga').setup({
                debug = false,
                use_saga_diagnostic_sign = true,
                error_sign = "",
                warn_sign = "",
                hint_sign = "󰌶",
                diagnostic_header_icon = "   ",
                code_action_icon = " ",
                code_action_prompt = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
                finder_definition_icon = "  ",
                finder_reference_icon = "  ",
                max_preview_lines = 10,
                finder_action_keys = {
                    open = "o", vsplit = "s", split = "i", quit = "q",
                    scroll_down = "<C-f>", scroll_up = "<C-b>"
                },
                code_action_keys = { quit = "q", exec = "<CR>" },
                rename_action_keys = { quit = "<C-c>", exec = "<CR>" },
                definition_preview_icon = "󱡴  ",
                border_style = "single",
                rename_prompt_prefix = "➤",
                diagnostic_prefix_format = "%d. "
            })
        end
    },
}
