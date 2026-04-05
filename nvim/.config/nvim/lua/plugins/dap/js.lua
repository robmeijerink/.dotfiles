local dap = require("dap")

require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal' },
})

for _, language in ipairs({ "typescript", "javascript", "vue" }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (Node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Debug in Chrome (localhost:3000)",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = false,
        },
    }
end
