-- =========================================================
-- Plugin: DAP Orchestrator (Lazy Loaded Debugging)
-- =========================================================
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "mxsdev/nvim-dap-vscode-js",
        {
            "microsoft/vscode-js-debug",
            build = "npm ci --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
        },
    },
    -- De trigger: Laad DAP pas als een van deze toetsen wordt ingedrukt
    keys = {
        { "<F5>",       function() require("dap").continue() end,                                             desc = "Debug: Start/Continue" },
        { "<F10>",      function() require("dap").step_over() end,                                            desc = "Debug: Step Over" },
        { "<F11>",      function() require("dap").step_into() end,                                            desc = "Debug: Step Into" },
        { "<F12>",      function() require("dap").step_out() end,                                             desc = "Debug: Step Out" },
        { "<leader>b",  function() require("dap").toggle_breakpoint() end,                                    desc = "Debug: Toggle Breakpoint" },
        { "<leader>B",  function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional Breakpoint" },
        { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Debug: Toggle UI" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- UI & Visuals Setup
        dapui.setup()
        require("nvim-dap-virtual-text").setup({})

        -- UI listeners: Open/sluit de debug interface automatisch
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        vim.fn.sign_define('DapBreakpoint', { text = '󰏃', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapStopped', { text = '󰁕', texthl = 'DapStopped', linehl = 'Visual' })

        -- Load Language Specific Modules
        require("plugins.dap.go")
        require("plugins.dap.php")
        require("plugins.dap.js")
    end,
}
