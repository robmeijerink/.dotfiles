require('robmeijerink.plugins')
require('robmeijerink.settings')
require('robmeijerink.debugger')

-- Require local config file if the file exists
local f = io.open('./init_local.lua', 'r')
if f ~= nil then
    io.close(f)
    require('init_local')
end
