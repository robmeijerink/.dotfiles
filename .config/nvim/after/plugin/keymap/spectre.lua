local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("<leader>SS", "<cmd>lua require('spectre').open()<CR>")

-- search current word
nnoremap("<leader>SW", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vnoremap("<leader>SS", "<esc>:lua require('spectre').open_visual()<CR>")
-- search in current file
nnoremap("<leader>SP", "viw:lua require('spectre').open_file_search()<CR>")

-- run command :Spectre
