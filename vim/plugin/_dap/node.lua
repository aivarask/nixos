-- https://code.visualstudio.com/docs/nodejs/nodejs-debugging
-- https://github.com/mxsdev/nvim-dap-vscode-js
-- https://github.com/mxsdev/nvim-dap-vscode-js#manually
require('dap-vscode-js').setup({
  debugger_path = '/etc/nixos/vim/packages/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})
-- https://github.com/mfussenegger/nvim-dap/issues/20
require('dap.ext.vscode').load_launchjs('.vscode/launch.json', { ['pwa-node'] = { 'javascript' } })

-- require('dap').configurations.javascript = {
-- {
--   type = 'pwa-node',
--   request = 'launch',
--   name = 'Launch file',
--   program = '${file}',
--   cwd = '${workspaceFolder}',
--   console = 'integratedTerminal',
-- },
-- }
