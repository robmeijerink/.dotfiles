-- =========================================================
-- Plugin: DAP Orchestrator
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
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- UI & Visuals Setup
        dapui.setup()
        require("nvim-dap-virtual-text").setup({})

        -- UI listeners
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
