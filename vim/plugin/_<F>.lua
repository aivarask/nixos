wkr({
  ['<F1>'] = {
    function()
      vim.cmd.help(vim.fn.expand('<cword>'))
    end,
    'vim.cmd.help <cword>',
  },
  ['<F13>'] = {
    function()
      vim.cmd.help(vim.fn.expand('<cWORD>'))
    end,
    'vim.cmd.help <cWORD>',
  },
  ['<F25>'] = {
    function()
      vim.cmd.help(vim.fn.expand('<cexpr>'))
    end,
    'vim.cmd.help <cexpr>',
  },
})
