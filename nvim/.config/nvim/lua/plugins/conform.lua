-- =========================================================
-- Plugin: Conform (Auto-formatting) - Rob Meijerink
-- =========================================================
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
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
            php = { "pint", "phpcbf", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            vue = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            blade = { "blade-formatter" },
            go = { "gofmt", "goimports" },
            rust = { "rustfmt" },
            python = { "isort", "black" },
        },
        formatters = {
            phpcbf = {
                args = { "--standard=" .. vim.fn.expand("~/.dotfiles/codestyle/php/phpcs.xml"), "-" },
            },
            prettierd = {
                env = {
                    PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.dotfiles/codestyle/js/prettier.config.cjs"),
                },
                prepend_args = {
                    "--html-whitespace-sensitivity", "strict",
                },
            },
        },
        format_after_save = {
            lsp_fallback = true,
        },
        default_format_opts = {
            timeout_ms = 500,
        },
    },
}
