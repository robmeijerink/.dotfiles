return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Performance
    opts = { options = vim.opt.sessionoptions:get() },
    -- Expand on the Quit workflow (q)
    keys = {
        { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Last Session from current folder" },
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        { "<leader>qd", function() require("persistence").stop() end,                desc = "Stop Session Save (Quit without saving)" },
    },
}
