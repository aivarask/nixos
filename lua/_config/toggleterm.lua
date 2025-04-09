local toggleterm = require('toggleterm')
toggleterm.setup({
  shade_terminals = false,
  size = function(term)
    return term.direction == 'horizontal' and vim.o.lines * 0.4
        or (term.direction == 'vertical' and vim.o.columns * 0.3)
  end,
  float_opts = {
    width = function() return math.ceil(vim.o.columns * 0.8) end,
    height = function() return math.ceil(vim.o.lines * 0.8) end,
  },
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('toggleterm', {}),
  pattern = 'toggleterm',
  desc = '<esc> <C-\\><C-n>',
  callback = function()
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
  end,
})

local t = require('toggleterm.terminal').Terminal
empty = t:new({ cmd = '', hidden = true, direction = 'float' })
lf = t:new({ cmd = 'lf', hidden = true, direction = 'float' })
lg = t:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
man = t:new({ cmd = 'fzf-man-widget', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '`', '<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set({ 'n', 't' }, '\\l', function() lg:toggle(nil, 'float') end, { desc = 'lazygit' })
vim.keymap.set({ 'n', 't' }, '|1', function() lf:toggle(nil, 'float') end, { desc = 'lf' })
