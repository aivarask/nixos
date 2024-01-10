-- https://github.com/jbyuki/one-small-step-for-vimkind#configuration
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

dap.adapters.nlua = function(callback, config)
  callback({
    type = 'server',
    host = config.host or '127.0.0.1',
    port = config.port or 8086,
  })
end

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

local osv = require('osv')

wkr({
  o = {
    name = 'osv',
    s = {
      function() osv.start_server('127.0.0.1', 8086) end,
      'start_server',
    },
    ['?'] = { osv.is_running, 'is_running' },
    r = { osv.run_this, 'run_this' },
    m = {
      function() require('pl.pretty')(osv.server_messages) end,
      'server_messages',
    },
    l = {
      function() osv.launch(config) end,
      'launch()',
    },
  },
}, { prefix = '<leader>' })
