local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap

-- Show dependency versions
nnoremap('<LEADER>ns', require("package-info").show)

-- Hide dependency versions
nnoremap('<LEADER>nc', require("package-info").hide)

-- Toggle dependency versions
nnoremap('<LEADER>nt', require("package-info").toggle)

-- Update dependency on the line
nnoremap('<LEADER>nu', require("package-info").update)

-- Delete dependency on the line
nnoremap('<LEADER>nd', require("package-info").delete)

-- Install a new dependency
nnoremap('<LEADER>ni', require("package-info").install)

-- Install a different dependency version
nnoremap('<LEADER>np', require("package-info").change_version)
