wkr({
  name = 'Yank',
  ['%'] = {
    function()
      vim.fn.setreg('"', vim.fn.expand('%'))
    end,
    'let @"= expand("%:p")',
  },
}, { prefix = '<leader>y' })
