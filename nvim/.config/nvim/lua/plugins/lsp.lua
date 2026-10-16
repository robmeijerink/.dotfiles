-- =========================================================
-- Plugin: LSP Suite (Rob Meijerink)
-- Focus: Bare-metal LSP configuration without wrapper overhead
-- =========================================================
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvimdev/lspsaga.nvim",
        "ray-x/lsp_signature.nvim",
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Native Neovim 0.11+ API: defaults for every server, then per-server overrides.
        -- mason-lspconfig (v2) calls vim.lsp.enable() for every installed server.
        vim.lsp.config("*", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    completion = { callSnippet = "Replace" },
                    hint = { enable = true },
                }
            }
        })

        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = { command = "clippy" }, -- Clippy diagnostics on save
                    cargo = { allFeatures = true },
                    inlayHints = {
                        closureReturnTypeHints = { enable = "with_block" },
                        lifetimeElisionHints = { enable = "skip_trivial" },
                    },
                },
            },
        })

        require("mason-lspconfig").setup({
            automatic_enable = true,
        })

        -- =========================================================
        -- UI & Diagnostics
        -- =========================================================
        vim.diagnostic.config({
            virtual_text = { spacing = 5, severity = { min = vim.diagnostic.severity.WARN } },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "if_many",
                focusable = false,
            },
        })

        require("lsp_signature").setup({
            debug = false,
            bind = true,
            doc_lines = 0,
            floating_window = false,
            hint_enable = true,
            noice = true,
        })

        -- LSPSaga UI
        require("lspsaga").setup({
            ui = {
                border = "single",
                code_action = " ",
            },
            diagnostic = { show_code_action = true, show_source = true, jump_num_shortcut = true },
            lightbulb = { enable = true, sign = true, virtual_text = false },
            symbol_in_winbar = { enable = false }, -- Handled by Lualine
        })

        -- =========================================================
        -- 4. LSP Keybindings (Replacing lsp-zero's hidden magic)
        -- Executed strictly when an LSP attaches to the current buffer
        -- =========================================================
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("robmeijerink_lsp_attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Navigation (Telescope provides the fastest fuzzy finding for these)
                local builtin = require("telescope.builtin")
                map("gd", builtin.lsp_definitions, "Go to Definition")
                map("gr", builtin.lsp_references, "Go to References")
                map("gI", builtin.lsp_implementations, "Go to Implementation")
                map("<leader>D", builtin.lsp_type_definitions, "Type Definition")

                -- Actions & UI (Lspsaga provides the premium B2B interfaces)
                map("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
                map("<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename Variable")
                map("<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
                map("pd", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition")

                -- Diagnostics navigation
                map("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
                map("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")

                -- Inlay hints (on by default, <leader>th toggles)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
                            { bufnr = event.buf })
                    end, "Toggle Inlay Hints")
                end
            end,
        })
    end,
}
