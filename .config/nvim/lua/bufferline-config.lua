require('bufferline').setup {
    options = {
        offsets = {{filetype = "NvimTree", text = "" , text_align = "left" }},
    },
    highlights = {
        buffer_selected = {
            underline = false,
            undercurl = false,
            italic = true,
        },
    }
}
