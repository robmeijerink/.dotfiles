local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap

nnoremap('<leader>0b', ':lua require"dap".set_breakpoint()<CR>')
nnoremap('<leader>0B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nnoremap('<leader>0t', function() require"dap".toggle_breakpoint() end)
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
