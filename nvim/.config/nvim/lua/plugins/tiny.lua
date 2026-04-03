-- =========================================================
-- Plugin: Tiny Utilities (Rob Meijerink Architecture)
-- =========================================================
return {
    -- Tim Pope Essentials
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-unimpaired" },
    { "tpope/vim-sleuth", lazy = true },
    { "tpope/vim-eunuch", cmd = { "Rename", "SudoWrite", "Delete", "Chmod" } },

    -- Navigation & Editing
    { "christoomey/vim-tmux-navigator", lazy = false },
    { "nelstrom/vim-visual-star-search" },
    { "jessarcher/vim-heritage" },
    { "moll/vim-bbye" },
    { "TamaMcGlinn/quickfixdd" },

    -- Syntax & Language Helpers
    { "othree/javascript-libraries-syntax.vim", ft = { "javascript", "typescript", "vue" } },

    -- HTML/XML attributes text object
    {
        'whatyouhide/vim-textobj-xmlattr',
        dependencies = { 'kana/vim-textobj-user' }
    },

    -- SplitJoin (One-liner to multi-line)
    {
        'AndrewRadev/splitjoin.vim',
        config = function()
            vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_php_method_chain_full = 1
        end
    },

    -- Smart Paste (Pasta)
    {
        'sickill/vim-pasta',
        config = function()
            vim.g.pasta_disabled_filetypes = { 'fugitive' }
        end
    },
}
