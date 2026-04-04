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
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            -- Sequence: Try Laravel Pint first. If it fails/not found, use phpcbf with custom ruleset.
            php = { "pint", "phpcbf" },
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
        formatters = {
            phpcbf = {
                -- Pointing to the personal standard defined in your dotfiles
                args = { "--standard=" .. vim.fn.expand("~/.dotfiles/codestyle/php/phpcs.xml"), "-" },
            },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = true,
        },
    },
}

