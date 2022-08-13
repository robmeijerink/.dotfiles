require'lspconfig'.volar.setup{
  init_options = {
    typescript = {
      serverPath = '~/.npm/lib/node_modules/typescript/lib/tsserverlib.js'
      -- Alternative location if installed as root:
      -- serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
    }
  }
}