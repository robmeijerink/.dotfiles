-- =========================================================
-- Plugin: Mason & Tool Installer
-- Focus: Self-bootstrapping dependencies
-- =========================================================
return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup({
            ui = { border = "rounded" }
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                -- Go
                "gopls",
                "delve",

                -- PHP
                "intelephense",
                "phpstan",
                "php-debug-adapter",

                -- Frontend (Vue/JS)
                "eslint_d",
                "typescript-language-server",
                "vue-language-server",
                "tailwindcss-language-server",
            },
            -- Async
            run_on_start = true,
        })
    end,
}
