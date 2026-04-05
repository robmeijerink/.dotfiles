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
            php = { { "pint", "phpcbf" } },
            blade = { "blade-formatter" },
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            vue = { { "prettierd", "prettier" } },
            go = { "gofmt", "goimports" },
            rust = { "rustfmt" },
            python = { "isort", "black" },
            css = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
        },
        formatters = {
            phpcbf = {
                args = { "--standard=" .. vim.fn.expand("~/.dotfiles/codestyle/php/phpcs.xml"), "-" },
            },
        },
        -- Save Async
        format_after_save = {
            lsp_fallback = true,
        },
        default_format_opts = {
            timeout_ms = 500,
        },
    },
}
