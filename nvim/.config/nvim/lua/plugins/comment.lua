-- =========================================================
-- Plugin: Comment.nvim (Rob Meijerink Architecture)
-- =========================================================
return {
    'numToStr/Comment.nvim',
    event = "BufReadPost",
    opts = {
        padding = true,
        sticky = true,
        toggler = { line = 'gcc', block = 'gbc' },
        opleader = { line = 'gc', block = 'gb' },
        extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
        mappings = { basic = true, extra = true, extended = false },
    }
}
