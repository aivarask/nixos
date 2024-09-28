vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })
require('persistent-breakpoints').setup({
  save_dir = vim.fn.stdpath('data') .. '/breakpoints',
  load_breakpoints_event = 'BufReadPost',
})

--- @see dap-adapter
--- @see dap-configuration
dap = require('dap')
widgets = require('dap.ui.widgets')
dap.defaults.fallback.focus_terminal = true
require('nvim-dap-virtual-text').setup({})
require('persistent-breakpoints').setup({ load_breakpoints_event = { 'BufReadPost' } })

osv = require('osv')
dap.adapters = {
  nlua = function(callback, config)
    callback({ type = 'server', host = '127.0.0.1', port = 8086 })
  end,
  run_this = function(callback, config, parent)
    require('osv').run_this()
  end,
}
dap.configurations.lua = {
  { name = 'run_this', request = 'launch', type = 'run_this' },
}

require('which-key').add({
  --- @see dap-mappings
  { '<F5>', dap.continue, desc = 'dap.continue' },
  { '<F6>', [[:PBToggleBreakpoint<cr>]] },
  {
    '<F7>',
    function()
      dap.list_breakpoints(true)
    end,
    desc = 'list_breakpoints',
  },
  { '<F8>', [[:PBClearAllBreakpoints<cr>]] },
  { '<leader>td', group = 'dap' },
  { '<leader>tdc', [[:Telescope dap commands<cr>]] },
  { '<leader>tdC', [[:Telescope dap configurations<cr>]] },
  { '<leader>tdf', [[:Telescope dap frames<cr>]] },
  { '<leader>tdl', [[:Telescope dap list_breakpoints<cr>]] },
  { '<leader>tdv', [[:Telescope dap variables<cr>]] },
})
