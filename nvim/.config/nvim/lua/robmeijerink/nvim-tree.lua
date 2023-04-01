-- setup with some options
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
    icons = {
        show  = {
            folder_arrow = false
        }
    },
    indent_markers = {
        enable = true
    }
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
