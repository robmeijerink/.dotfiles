-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
    mappings = {
      list = {
        -- { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
})