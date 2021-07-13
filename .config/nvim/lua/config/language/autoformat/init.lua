local clang = require('config.language.autoformat.clang')
local python = require('config.language.autoformat.python')
local utils = require('utils')

require('formatter').setup({
  logging = true,
  filetype = {
    c = clang,
    python = python
  }
})

utils.create_augroup({
    { 'BufWritePost', '*.c,*.py', 'FormatWrite' }
}, 'FormatAutogroup')
