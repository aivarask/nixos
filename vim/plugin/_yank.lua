wkr({
  name = 'Yank',
  p = {
    function()
      vim.fn.setreg('p', vim.fn.expand('%:p'))
    end,
    'let @p=expand("%:p")',
  },
  ['r'] = {
    function()
      vim.fn.setreg('r', vim.fn.expand('%'))
    end,
    'let @p=expand("%")',
  },
}, { prefix = '<leader>y' })
