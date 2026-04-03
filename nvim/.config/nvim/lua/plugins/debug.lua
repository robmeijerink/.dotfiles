-- =========================================================
-- Plugin: Debugger (DAP) - Rob Meijerink Architecture
-- =========================================================
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        -- Base mappings
        { "<leader>0t", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>0b", function() require("dap").set_breakpoint() end, desc = "Set Breakpoint" },
        { "<leader>0B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },

        -- Stepping
        { "<A-k>", function() require("dap").step_out() end, desc = "Step Out" },
        { "<A-l>", function() require("dap").step_into() end, desc = "Step Into" },
        { "<A-j>", function() require("dap").step_over() end, desc = "Step Over" },
        { "<A-h>", function() require("dap").continue() end, desc = "Continue/Start" },

        -- Management & Attach (Native Replacements for debugHelper)
        { "<leader>0a", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
            -- Native process picker
            local dap = require('dap')
            dap.continue()
        end, desc = "Attach to Process" },

        { "<leader>0A", function()
            local dap = require('dap')
            local port = vim.fn.input('Port: ', '9229')
            local host = vim.fn.input('Host: ', '127.0.0.1')
            if port ~= "" then
                dap.run({
                    type = 'node2',
                    request = 'attach',
                    address = host,
                    port = tonumber(port),
                    sourceMaps = true,
                })
            end
        end, desc = "Attach to Remote (Node)" },

        { "<leader>0n", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>0c", function() require("dap").terminate() end, desc = "Terminate Session" },
        { "<leader>0R", function() require("dap").clear_breakpoints() end, desc = "Clear All Breakpoints" },

        -- UI & Navigation
        { "<leader>0i", function() require("dap.ui.widgets").hover() end, desc = "DAP Hover" },
        { "<leader>0?", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end, desc = "DAP Scopes" },
        { "<leader>0k", function() require("dap").up() end, desc = "Stack Up" },
        { "<leader>0j", function() require("dap").down() end, desc = "Stack Down" },
        { "<leader>0r", function() require("dap").repl.toggle({}, "vsplit") end, desc = "Toggle REPL" },

        -- Telescope
        { "<leader>0fd", "<cmd>Telescope dap frames<CR>", desc = "DAP Frames" },
        { "<leader>0fb", "<cmd>Telescope dap list_breakpoints<CR>", desc = "DAP List Breakpoints" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local home = os.getenv('HOME')

        -- UI Setup
        require("nvim-dap-virtual-text").setup({})
        dapui.setup({
            layouts = {
                { elements = { "console" }, size = 7, position = "bottom" },
                { elements = { { id = "scopes", size = 0.25 }, "watches" }, size = 40, position = "left" }
            },
        })

        -- Signs & Visuals
        vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

        -- Auto-open UI
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open(1) end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        -- Adapters & Configs (Node/PHP)
        dap.adapters.node2 = {
            type = 'executable',
            command = 'node',
            args = { home .. '/apps/node/out/src/nodeDebug.js' },
        }

        dap.adapters.php = {
            type = 'executable',
            command = 'node',
            args = { home .. "/.vscode/extensions/xdebug.php-debug-1.32.1/out/phpDebug.js" }
        }

        dap.configurations.javascript = {
            {
                name = 'Attach to process',
                type = 'node2',
                request = 'attach',
                processId = require('dap.utils').pick_process,
            },
            {
                name = 'Launch File',
                type = 'node2',
                request = 'launch',
                program = '${file}',
                cwd = vim.loop.cwd(),
                sourceMaps = true,
                protocol = 'inspector',
                console = 'integratedTerminal',
            },
        }

        dap.configurations.php = {
            {
                type = 'php',
                request = 'launch',
                name = 'Listen for xdebug',
                port = 9003,
                pathMappings = { ["/var/www/html"] = "${workspaceFolder}" },
            },
        }

        require('telescope').load_extension('dap')
    end
}
