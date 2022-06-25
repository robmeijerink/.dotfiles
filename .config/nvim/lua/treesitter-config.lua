vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {spacing = 5, severity_limit = 'Warning'},
      update_in_insert = true
    })

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "bash",
      "html",
      "css",
      "scss",
      "javascript",
      "typescript",
      "vue",
      "lua",
      "php",
      "go",
      "gomod",
      "rust",
      "dockerfile",
      "yaml",
      "toml"
  },
  sync_installed = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      "php"
    }
  },
  indent = {
    enable = false -- Really breaks stuff if true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    },
  },
  autotag = {enable = true},
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autopairs = {enable = true}
}

-- Enable folds (zc and zo) on functions and classes but not by default
-- vim.cmd([[
--   set nofoldenable
--   set foldmethod=expr
--   set foldexpr=nvim_treesitter#foldexpr()
-- ]])