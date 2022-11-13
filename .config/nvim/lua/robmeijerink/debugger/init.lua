local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap

-- mfussenegger/nvim-dap
local dap = require("dap")
-- rcarriga/nvim-dap-ui
local dapui = require("dapui")
-- theHamsta/nvim-dap-virtual-text
local daptext = require("nvim-dap-virtual-text")

daptext.setup({})
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
require('robmeijerink.debugger.php')

-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

nnoremap('<leader>0b', ':lua require"dap".set_breakpoint()<CR>')
nnoremap('<leader>0b', function() require"dap".toggle_breakpoint() end)
nnoremap('<leader>0B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nnoremap('<A-k>', function() require"dap".step_out() end)
nnoremap("<A-l>", function() require"dap".step_into() end)
nnoremap('<A-j>', function() require"dap".step_over() end)
nnoremap('<A-h>', function() require"dap".continue() end)
nnoremap('<leader>0n', function() require"dap".run_to_cursor() end)
nnoremap('<leader>0c', function() require"dap".terminate() end)
nnoremap('<leader>0R', function() require"dap".clear_breakpoints() end)
nnoremap('<leader>0e', function() require"dap".set_exception_breakpoints({"all"}) end)
nnoremap('<leader>0a', function() require"debugHelper".attach() end)
nnoremap('<leader>0A', function() require"debugHelper".attachToRemote() end)
nnoremap('<leader>0i', function() require"dap.ui.widgets".hover() end)
nnoremap('<leader>0?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
nnoremap('<leader>0k', ':lua require"dap".up()<CR>zz')
nnoremap('<leader>0j', ':lua require"dap".down()<CR>zz')
nnoremap('<leader>0r', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

-- nvim-telescope/telescope-dap.nvim

nnoremap('<leader>0fd', ':Telescope dap frames<CR>')
-- nnoremap('<leader>dc', ':Telescope dap commands<CR>')
nnoremap('<leader>0fb', ':Telescope dap list_breakpoints<CR>')
