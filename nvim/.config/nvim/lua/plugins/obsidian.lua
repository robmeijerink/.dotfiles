-- =========================================================
-- Plugin: Obsidian.nvim
-- Focus: Markdown knowledge base and project documentation
-- =========================================================
return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "global_vault",
                path = "~/Dropbox/Obsidian/RobMainVault",
            },
            {
                name = "project_docs",
                path = function()
                    -- Falls back to the current working directory (useful for project /docs)
                    return assert(vim.fn.getcwd())
                end,
            },
        },

        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        note_id_func = function(title)
            local suffix = ""
            if title ~= nil then
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                suffix = tostring(os.time())
            end
            return tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
        end,

        disable_frontmatter = false,

        templates = {
            folder = "98_Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },

        mappings = {
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },
    },

    -- =========================================================
    -- The config function loads the opts AND applies the autocmd
    -- =========================================================
    config = function(_, opts)
        -- 1. Setup the plugin with the opts defined above
        require("obsidian").setup(opts)

        -- 2. Force conceallevel=2 only for markdown files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown" },
            callback = function()
                vim.opt_local.conceallevel = 2
            end,
        })
    end,
}
