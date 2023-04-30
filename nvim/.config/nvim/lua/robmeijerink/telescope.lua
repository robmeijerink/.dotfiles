local actions = require('telescope.actions')
local trouble = require("trouble.providers.telescope")
local lga_actions = require("telescope-live-grep-args.actions")
local grep_args = { '--hidden', '--glob', '!**/.git/*' }

require('telescope').setup {
  defaults = {
    layout_config = {
      width = 0.75,
      prompt_position = "top",
      preview_cutoff = 120,
      horizontal = {mirror = false},
      vertical = {mirror = false}
    },
    find_command = {
      'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--iglob', '!.git', '--hidden', '--no-ignore-vcs'
    },
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {
        -- "node_modules",
        -- "vendor",
        ".git",
        ".idea",
        ".vscode",
        "htdocs",
    },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-t>"] = trouble.open_with_trouble
      }
    }
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
    },
    live_grep = {
      additional_args = function(opts)
        return grep_args
      end
    },
    grep_string = {
      additional_args = function(opts)
        return grep_args
      end
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt({ postfix = " --hidden --no-ignore" }),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob --hidden --no-ignore" }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'lazygit')
pcall(require('telescope').load_extension, 'dap')
