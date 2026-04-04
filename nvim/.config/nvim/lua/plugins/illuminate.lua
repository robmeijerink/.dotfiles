-- =========================================================
-- Plugin: vim-illuminate
-- =========================================================
return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
        vim.g.illuminate_ft_denylist = { "sh", "bash", "zsh", "NvimTree" }
    end,
    config = function()
        require("illuminate").configure({
            providers = { 'lsp', 'regex' },
            delay = 200,
            under_cursor = true,
        })
    end,
}