local null_ls = require('null-ls')
null_ls.register({
  sources = {
    -- https://makefiletutorial.com
    -- https://github.com/mrtazz/checkmake
    null_ls.builtins.diagnostics.checkmake,
  },
})
