require('bufferline').setup {
    options = {
        offsets = {{filetype = "NvimTree", text = "" , text_align = "left" }},
    },
    highlights = {
        buffer_selected = {
            gui = "italic"
        },
    }
}
