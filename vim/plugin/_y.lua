wkr({
  name = 'Yank ...',
  ['%'] = {
    function()
      vim.fn.setreg('"', vim.fn.expand('%'))
    end,
    '%',
  },
}, { prefix = 'y<leader>' })
