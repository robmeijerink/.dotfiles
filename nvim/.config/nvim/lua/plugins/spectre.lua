-- =========================================================
-- Plugin: Spectre (Visual Search and Replace tool
-- =========================================================
return {
    'nvim-pack/nvim-spectre',
    cmd = "Spectre",
    opts = {
        open_cmd = "noswapfile vnew",
        live_update = true,
    },
    keys = {
        { "<leader>SS", function() require("spectre").toggle() end,                                 desc = "Toggle Spectre" },
        { "<leader>SW", function() require("spectre").open_visual({ select_word = true }) end,      desc = "Search Current Word" },
        { "<leader>SF", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search in Current File" },
    }
}
