require("luasnip.loaders.from_vscode").lazy_load()

-- Extends Filetypes with frameworks etc.
require('luasnip').filetype_extend("javascript", {"vue"})
require('luasnip').filetype_extend("html", {"javascript"})
require('luasnip').filetype_extend("blade", {"javascript"})