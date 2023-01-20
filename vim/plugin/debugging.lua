-- https://github.com/mxsdev/nvim-dap-vscode-js
require('dap-vscode-js').setup({
  -- which adapters to register in nvim-dap
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
vim.keymap.set('n', '<space>b', require('dap').toggle_breakpoint)
-- vim.keymap.set('n', '<space>c', require('dap').continue)
vim.keymap.set('n', '<space>so', require('dap').step_over)
vim.keymap.set('n', '<space>si', require('dap').step_into)
vim.keymap.set('n', '<space>dr', require('dap').repl.toggle)
vim.keymap.set('n', '<space>dl', require('dap').launch)
vim.keymap.set('n', '<space>k', require('dap.ui.widgets').hover)

-- https://github.com/rcarriga/nvim-dap-ui
require('dapui').setup()
vim.keymap.set('n', '<space>dt', require('dapui').toggle)

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
local dap = require('dap')
for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end
-- https://github.com/jbyuki/one-small-step-for-vimkind#configuration
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end
-- vim.keymap.set('n', '<F5>', function()
--   require('osv').launch({ port = 8086 })
-- end)
