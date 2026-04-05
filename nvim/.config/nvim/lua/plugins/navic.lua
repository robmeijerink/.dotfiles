-- =========================================================
-- Plugin: nvim-navic
-- Role: Data provider for breadcrumbs (LSP-based)
-- =========================================================
return {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
        vim.g.navic_silence = true

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("navic_attach", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                if client and client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, args.buf)
                end
            end,
        })
    end,
    opts = {
        highlight = true,
        depth_limit = 5,
        lazy_update_context = true,
    },
}