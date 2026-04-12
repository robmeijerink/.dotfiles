-- =========================================================
-- Plugin: vim-illuminate
-- Focus: Highlight matching words under cursor
-- =========================================================
return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("illuminate").configure({
            providers = { 'lsp', 'treesitter', 'regex' },
            delay = 200,
            under_cursor = true,
            large_file_cutoff = 2000,

            filetypes_denylist = {
                "oil",
                "TelescopePrompt",
                "harpoon",
                "lazy",
                "mason",
                "sh",
                "bash",
                "zsh",
            },
        })
    end,
}
