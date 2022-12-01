local Remap = require("robmeijerink.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", function()
    require('telescope.builtin').git_files()
end)

-- See `:help telescope.builtin`
nnoremap('<leader>?', function()
  require('telescope.builtin').oldfiles()
end, { desc = '[?] Find recently opened files' })

nnoremap('<leader><space>', function()
  require('telescope.builtin').buffers()
end, { desc = '[ ] Find existing buffers' })

nnoremap('<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
