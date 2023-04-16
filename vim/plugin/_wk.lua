-- https://github.com/folke/which-key.nvim
vim.o.timeout = true
vim.o.timeoutlen = 200
require('which-key').setup({})

local wk = require('which-key')
wk.register({
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
  ['<leader>g'] = {
    x = {
      function()
        vim.cmd([[!xdg-open ]] .. vim.fn.expand('<cfile>'))
      end,
      '!xdg-open <cfile>',
    },
  },
  ['<leader>t'] = {
    name = 'Telescope',
    t = { '<cmd>Telescope<cr>', 'Telescope' },
    k = { [[:Telescope keymaps<CR>]], 'Telescope keymaps' },
    p = { [[:Telescope projects<CR>]], 'Telescope projects' },
    h = { [[:Telescope help_tags<CR>]], 'Telescope helptags' },
    l = {
      name = 'LSP',
      d = { [[:Telescope lsp_document_symbols<CR>]], 'Telescope lsp_document_symbols' },
      w = { [[:Telescope lsp_workspace_symbols<CR>]], 'Telescope lsp_workspace_symbols' },
      x = { [[:Telescope lsp_dynamic_workspace_symbols<CR>]], 'Telescope lsp_dynamic_workspace_symbols' },
    },
  },
})
