-- =========================================================
-- Plugin: Fidget.nvim (Rob Meijerink)
-- Focus: LSP Progress & Notifications UI
-- =========================================================
return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        -- Progress reporting
        progress = {
            display = {
                done_ttl = 3,
                progress_icon = { pattern = "dots", period = 1 },
            },
        },
        notification = {
            override_vim_notify = true,
            window = {
                winblend = 0,
                border = "none",
            },
        },
    },
}
