-- =========================================================
-- Plugin: vim-tmux-navigator
-- Focus: Seamless navigation between Neovim splits and Tmux panes
-- =========================================================
return {
    "christoomey/vim-tmux-navigator",
    -- We load it immediately because it handles basic Ctrl+hjkl mappings
    lazy = false,
}
