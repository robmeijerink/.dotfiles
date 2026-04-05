-- =========================================================
-- Plugin: Toggleterm (Rob Meijerink)
-- =========================================================
return {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- Load on the keymap you defined
    keys = {
        { [[<C-\>]], "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    },
    opts = {
        size = 13,
        open_mapping = [[<c-\>]],
        shade_terminals = true,
        shading_factor = '1',
        start_in_insert = true,
        persist_size = true,
        direction = 'horizontal',
    }
}
