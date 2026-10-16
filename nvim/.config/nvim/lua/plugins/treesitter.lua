-- =========================================================
-- Native Treesitter Attachment (Neovim 0.10+)
-- Focus: This was added mainly because highlighting in blade files did not work
-- =========================================================
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("RobMeijerinkTreesitter", { clear = true }),
    desc = "Start native Treesitter highlighting automatically",
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if lang then
            local ok = pcall(vim.treesitter.start, args.buf, lang)

            if ok then
                vim.bo[args.buf].syntax = "off"

                -- Treesitter indent (native nvim engine handles php/blade)
                if lang ~= "php" and lang ~= "blade" then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end
        end
    end,
})

-- =========================================================
-- Plugin: Treesitter Configuration
-- =========================================================
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        priority = 1000,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        },
        config = function()
            -- The main branch no longer supports ensure_installed/highlight/indent/textobjects
            -- in setup(). Parsers are installed explicitly (no-op when already present).
            require("nvim-treesitter").install({
                "bash", "html", "css", "scss", "javascript", "typescript",
                "vue", "lua", "luadoc", "php", "go", "rust", "blade",
                "dockerfile", "yaml", "toml", "json", "vim", "vimdoc",
            })

            -- Textobjects (main branch: setup + explicit keymaps)
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            local select = require("nvim-treesitter-textobjects.select")
            for keys, query in pairs({
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
            }) do
                vim.keymap.set({ "x", "o" }, keys, function()
                    select.select_textobject(query, "textobjects")
                end, { desc = "TS: " .. query })
            end

            local move = require("nvim-treesitter-textobjects.move")
            for keys, args in pairs({
                ["]m"] = { move.goto_next_start, "@function.outer" },
                ["]]"] = { move.goto_next_start, "@class.outer" },
                ["[m"] = { move.goto_previous_start, "@function.outer" },
                ["[["] = { move.goto_previous_start, "@class.outer" },
            }) do
                vim.keymap.set({ "n", "x", "o" }, keys, function()
                    args[1](args[2], "textobjects")
                end, { desc = "TS: " .. args[2] })
            end

            local swap = require("nvim-treesitter-textobjects.swap")
            vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner") end,
                { desc = "TS: Swap next parameter" })
            vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end,
                { desc = "TS: Swap previous parameter" })
        end,
    },

    -- 1. Context Commentstring
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        opts = { enable_autocmd = false },
        config = function(_, opts)
            vim.g.skip_ts_context_commentstring_module = true
            require('ts_context_commentstring').setup(opts)
        end
    },

    -- 2. Autotag
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {},
    },

    -- 3. Context (Sticky Headers)
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        opts = { mode = "cursor", max_lines = 3 }
    }
}
