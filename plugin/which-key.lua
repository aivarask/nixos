local wk = require('which-key')
wk.setup({
  preset = 'helix',
  sort = { 'alphanum' },
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help_window_right', {}),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then
      if vim.o.columns > 120 then
        vim.cmd.wincmd('L')
      end
      if vim.fn.winwidth(0) < 100 then
        vim.cmd([[wincmd T]])
      end
    end
  end,
})

wk.add({
  { '<M-f>', '<cmd>Telescope find_files<CR>' },
  { '<M-g>', [[:Telescope live_grep<CR>]] },
  {
    '??',
    function()
      vim.ui.select({
        { 'all', {} },
        { 'user', { global = false } },
        { 'normal', { mode = 'n' } },
        { 'insert', { mode = 'i' } },
        { 'visual', { mode = 'v' } },
        { 'command', { mode = 'c' } },
      }, {
        format_item = function(item)
          return item[1]
        end,
      }, function(item)
        if item ~= nil then
          require('which-key').show(item[2])
        end
      end)
    end,
  },
})
