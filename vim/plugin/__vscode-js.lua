-- https://github.com/mxsdev/nvim-dap-vscode-js
require('dap-vscode-js').setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = '/root/vscode-js-debug', -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    -- {
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'Launch file',
    --   program = '${file}',
    --   cwd = '${workspaceFolder}',
    -- },
    -- {
    --   type = 'pwa-node',
    --   request = 'attach',
    --   name = 'Attach',
    --   processId = require('dap.utils').pick_process,
    --   cwd = '${workspaceFolder}',
    -- },
    -- {
    --   -- https://vitest.dev/guide/debugging.html#vscode
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'Debug Current Test File',
    --   autoAttachChildProcesses = true,
    --   skipFiles = { '<node_internals>/**', '**/node_modules/**' },
    --   program = '${workspaceRoot}/node_modules/vitest/vitest.mjs',
    --   cwd = '${workspaceFolder}',
    --   args = { 'run', '${relativeFile}' },
    --   smartStep = true,
    --   console = 'integratedTerminal',
    -- },
    {
      -- followind quite useful
      -- https://github.com/mxsdev/nvim-dap-vscode-js/issues/19
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch Test Program (pwa-node with vitest)',
      cwd = vim.fn.getcwd(),
      program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
      args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
      autoAttachChildProcesses = true,
      smartStep = true,
      console = 'integratedTerminal',
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
  }
end
