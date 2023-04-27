-- https://github.com/mxsdev/nvim-dap-vscode-js
require('dap-vscode-js').setup({
  debugger_path = '/root/gh/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      -- https://vitest.dev/guide/debugging.html#vscode
      -- https://github.com/mxsdev/nvim-dap-vscode-js/issues/19
      name = 'vitest (pwa-node)',
      type = 'pwa-node',
      request = 'launch',
      cwd = vim.fn.getcwd(),
      program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
      args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
      autoAttachChildProcesses = true,
      smartStep = true,
      console = 'integratedTerminal',
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
    -- https://playwright.dev/docs/debug#playwright-inspector
    {
      name = 'playwright (pwa-chrome)',
      type = 'pwa-chrome',
      request = 'launch',
      cwd = vim.fn.getcwd(),
    },
    {
      name = 'launch (pwa-node)',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      name = 'attach (pwa-node)',
      type = 'pwa-node',
      request = 'attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
  }
end
