-- https://github.com/ThePrimeagen/refactoring.nvim
require('refactoring').setup({})

-- https://github.com/nvimtools/none-ls.nvim
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/MAIN.md#registration
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
  },
  diagnostics_format = 'NLS (#{s}) [#{c}] #{m}',
})
