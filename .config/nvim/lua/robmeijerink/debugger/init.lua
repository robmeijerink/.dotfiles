local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap

-- mfussenegger/nvim-dap
local dap = require("dap")
-- rcarriga/nvim-dap-ui
local dapui = require("dapui")
-- theHamsta/nvim-dap-virtual-text
local daptext = require("nvim-dap-virtual-text")

daptext.setup()
dapui.setup({
    layouts = {
        {
            elements = {
                "console",
            },
            size = 7,
            position = "bottom",
        },
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 40,
            position = "left",
        }
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require('robmeijerink.debugger.node')

-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

nnoremap('<leader>b', function() require"dap".set_breakpoint() end)
nnoremap('<leader>Dh', function() require"dap".toggle_breakpoint() end)
nnoremap('<leader>DH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nnoremap('<A-k>', function() require"dap".step_out() end)
nnoremap("<A-l>", function() require"dap".step_into() end)
nnoremap('<A-j>', function() require"dap".step_over() end)
nnoremap('<A-h>', function() require"dap".continue() end)
nnoremap('<leader>Dn', function() require"dap".run_to_cursor() end)
nnoremap('<leader>Dc', function() require"dap".terminate() end)
nnoremap('<leader>DR', function() require"dap".clear_breakpoints() end)
nnoremap('<leader>De', function() require"dap".set_exception_breakpoints({"all"}) end)
nnoremap('<leader>Da', function() require"debugHelper".attach() end)
nnoremap('<leader>DA', function() require"debugHelper".attachToRemote() end)
nnoremap('<leader>Di', function() require"dap.ui.widgets".hover() end)
nnoremap('<leader>D?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
nnoremap('<leader>Dk', ':lua require"dap".up()<CR>zz')
nnoremap('<leader>Dj', ':lua require"dap".down()<CR>zz')
nnoremap('<leader>Dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

-- nvim-telescope/telescope-dap.nvim

nnoremap('<leader>Ds', ':Telescope dap frames<CR>')
-- nnoremap('<leader>dc', ':Telescope dap commands<CR>')
nnoremap('<leader>Db', ':Telescope dap list_breakpoints<CR>')
