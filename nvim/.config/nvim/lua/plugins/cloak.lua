-- =========================================================
-- Plugin: Cloak.nvim (Hide secrets in .env files)
-- =========================================================
return {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    config = function()
        require("cloak").setup({
            enabled = true,
            cloak_character = "*",
            cloak_telemetry = false,
            cloak_rules = {
                {
                    file_pattern = { ".env*", "wrangler.toml", ".dev.vars" },
                    cloak_pattern = "=.+",
                },
                {
                    file_pattern = ".npmrc",
                    cloak_pattern = { "(_authToken=).+", "(:_).+" },
                },
                {
                    file_pattern = "auth.json",
                    cloak_pattern = '("password":\\s*")[^"]+',
                },
                {
                    file_pattern = { "docker-compose.yml", "docker-compose.yaml" },
                    cloak_pattern = { "(PASSWORD:\\s*).+", "(SECRET:\\s*).+" },
                },
            },
        })

        vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<CR>", { desc = "Toggle Cloak secrets" })
    end,
}
