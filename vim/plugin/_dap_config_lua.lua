-- https://github.com/jbyuki/one-small-step-for-vimkind#configuration
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
  -- { type = 'nlua', request = 'launch', name = 'Launch lua file', program = '${file}' },
}

local config = {
  host = '127.0.0.1',
  port = 8086,
  flatten_nvim = true,
}

dap.adapters.nlua = function(callback)
  print([[Let's start a server]])
  callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end

wkr({
  o = {
    name = 'osv',
    s = {
      function()
        osv.start_server('127.0.0.1', 8086)
      end,
      'start_server',
    },
    ['?'] = { osv.is_running, 'is_running' },
    r = { osv.run_this, 'run_this' },
    m = {
      function()
        require('pl.pretty')(osv.server_messages)
      end,
      'server_messages',
    },
    l = {
      function()
        osv.launch(config)
      end,
      'launch()',
    },
  },
}, { prefix = '<leader>' })
