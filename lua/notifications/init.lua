require('fidget').setup({})
nv = vim.notify
nf = require('fidget').notify

local wk = require('which-key')
wk.add({
  { '<C-M-H>', [[:Telescope help_tags<CR>]] },
  { '<C-M-G>', [[:Telescope live_grep<CR>]] },
  { '<C-M-K>', [[:Telescope keymaps<CR>]] },
  {
    '<leader><leader>s',
    function() vim.cmd.lua(vim.api.nvim_get_current_line()) end,
  },
  { '<leader>n', group = 'nix' },
  {
    '<leader>nn',
    function()
      vim.ui.select({
        'clock',
        'nixos-rebuild switch --verbose --fast',
        'nix flake metadata',
      }, {}, function(item, idx)
        if item ~= nil then
          local Job = require('plenary.job')
          local t = vim.split(item, ' ')
          local head = table.remove(t, 1)
          Job:new({
            command = head,
            args = t,
            on_stdout = function(_, line) vim.notify(line) end,
            on_exit = function(self, code, signal) require('pl.pretty')(self:result()) end,
          }):start()
        end
      end)
    end,
  },
  {
    '<leader>nd',
    function()
      -- vim.notify = require 'notify'
      local nio = require('nio')
      local notify = require('notify')
      notify.setup({ render = 'compact' })
      local task = nio.run(function()
        local prev = nil
        for i = 1, 3, 1 do
          local current = notify.notify(os.date(), vim.log.levels.INFO, { title = 'Date', replace = prev or nil })
          nio.sleep(1000)
          prev = current.id
        end
        notify.notify('Date notification end', vim.log.levels.WARN, { title = 'Date', replace = prev })
      end)
    end,
  },
})
