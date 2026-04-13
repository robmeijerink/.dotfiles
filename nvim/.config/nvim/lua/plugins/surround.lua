-- Works with the surround setting in /plugins/autopairs.lua
return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
}
