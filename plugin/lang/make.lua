local ftmap = require('null-ls.builtins._meta.filetype_map').make

local make = {
  diagnostics = { "checkmake" },
}

local null_ls = require('null-ls')
null_ls.register({
  sources = {
    null_ls.builtins.diagnostics.checkmake,
  },
})
