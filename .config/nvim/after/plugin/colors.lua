-- vim.g.rob_colorscheme = "tokyonight"
-- vim.g.rob_colorscheme = "gruvbox"
-- vim.g.rob_colorscheme = "nightfox"
vim.g.rob_colorscheme = "monokai_pro"

function ColorMyPencils()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.g.gruvbox_invert_selection = '0'
    vim.opt.background = "dark"

    vim.cmd("colorscheme " .. vim.g.rob_colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", {
        bg = "none",
    })

    hl("ColorColumn", {
        ctermbg = 0,
        bg = "#555555",
    })

    hl("CursorLineNR", {
        bg = "None"
    })

    hl("Normal", {
        bg = "none"
    })

    hl("LineNr", {
        fg = "#5eacd3"
    })

    hl("netrwDir", {
        fg = "#5eacd3"
    })

    hl("WinSeperator", {
        bg = "None",
    })

end
ColorMyPencils()

-- Vim with me
--[[
nnoremap <leader>cmp :call ColorMyPencils()<CR>
nnoremap <leader>vwb :let g:rob_colorscheme =
]]
