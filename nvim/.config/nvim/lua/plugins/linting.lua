-- =========================================================
-- Plugin: nvim-lint (Diagnostics) - Rob Meijerink
-- =========================================================
return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            php = { "phpstan" }, -- Or use "psalm" if preferred
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            vue = { "eslint_d" },
            python = { "pylint" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
