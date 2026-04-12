-- =========================================================
-- Plugin: vim-tmux-navigator
-- Focus: Seamless navigation between Neovim splits and Tmux panes
-- =========================================================
return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    keys = {
        { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>",     desc = "Window Left" },
        { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>",     desc = "Window Down" },
        { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>",       desc = "Window Up" },
        { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>",    desc = "Window Right" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Previous Window" },
    },
}
