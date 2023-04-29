require('nvim-treesitter.configs').setup {
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
        "toml",
        "http",
        "json",
    },
    sync_installed = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { 'NvimTree' },
        -- additional_vim_regex_highlighting = true,
        -- additional_vim_regex_highlighting = {
        --   "php"
        -- }
    },
    indent = {
        enable = true,
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
    autotag = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    autopairs = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ia'] = '@parameter.inner',
                ['aa'] = '@parameter.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
    context_commentstring = {
        enable = true,
    },
}

-- Enable folds (zc and zo) on functions and classes but not by default
-- vim.cmd([[
--   set nofoldenable
--   set foldmethod=expr
--   set foldexpr=nvim_treesitter#foldexpr()
-- ]])

-- Ensure everything is unfolded when opening a buffer
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    pattern = {"*"},
    command = "set foldlevel=99",
})