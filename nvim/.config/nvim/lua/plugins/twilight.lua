-- =========================================================
-- Plugin: Twilight (Dim inactive code)
-- =========================================================
return {
    "folke/twilight.nvim",
    keys = {
        { "<leader>zt", function() require("twilight").toggle() end, desc = "Toggle Twilight" },
    },
    opts = {
        -- Keep it clean and focused
        dimming = { alpha = 0.25 },
        context = 10,
    }
}
