-- =========================================================
-- Plugin: Neogen (Annotation & Docstring Generator)
-- =========================================================
return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    keys = {
        { "<leader>**", function() require("neogen").generate() end, desc = "Generate Docs" },
    },
    config = function()
        require("neogen").setup({
            snippet_engine = "luasnip",
            languages = {
                php = {
                    template = {
                        annotation_convention = "phpdoc"
                    }
                }
            }
        })
    end,
}
