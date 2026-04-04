-- =========================================================
-- Plugin: Conform (Auto-formatting) - Rob Meijerink
-- =========================================================
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>lf",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            php = { "pint", "phpcbf" }, -- Uses Laravel Pint if available, else phpcbf
            blade = { "blade-formatter" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            vue = { "prettierd", "prettier", stop_after_first = true },
            go = { "gofmt", "goimports" },
            rust = { "rustfmt" },
            python = { "isort", "black" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = true,
        },
    },
}
