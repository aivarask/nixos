wk = require('which-key')
wk.setup({})
wkr = require('which-key').register

function up() vim.cmd('cd ..') end

wkr({
  ['-'] = { up, 'cd ..' },

  -- ['-'] = { vim.fn['cd ..'], 'cd ..' },
  ['<M-4>'] = {
    vim.fn['ak#toggle_dollar'],
    'ak#toggle_dollar',
    mode = { 'n', 'i' },
  }, -- autoload/ak.vim
  ['<M-1>'] = { vim.fn['cs#one'], 'cs#one', mode = { 'n', 'i' } }, -- autoload/cs.vim
})
