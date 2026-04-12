-- =========================================================
-- Plugin: Tiny Utilities (Rob Meijerink)
-- =========================================================
return {
    -- Tim Pope Essentials
    { "tpope/vim-sleuth",                       event = "VeryLazy" }, -- Auto-detect indent (spaces / tabs)
    { "tpope/vim-surround",                     event = "VeryLazy" },
    { "tpope/vim-repeat",                       event = "VeryLazy" },
    { "tpope/vim-eunuch",                       cmd = { "Rename", "SudoWrite", "Delete", "Chmod" } },

    -- Navigation & Editing
    { "nelstrom/vim-visual-star-search",        event = "VeryLazy" },
    { "jessarcher/vim-heritage",                event = "VeryLazy" },
    { "TamaMcGlinn/quickfixdd",                 event = "VeryLazy" },

    -- Syntax & Language Helpers
    { "othree/javascript-libraries-syntax.vim", ft = { "javascript", "typescript", "vue" } },

    -- HTML/XML attributes text object
    {
        'whatyouhide/vim-textobj-xmlattr',
        dependencies = { 'kana/vim-textobj-user' },
        event = "VeryLazy",
    },
}
