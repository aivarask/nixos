-- https://github.com/mxsdev/nvim-dap-vscode-js
require('dap-vscode-js').setup({
  debugger_path = '/root/gh/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- https://code.visualstudio.com/docs/nodejs/nodejs-debugging
for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'vavite',
      runtimeExecutable = 'npm',
      runtimeArgs = { 'run', 'debug' },
      cwd = '${workspaceFolder}',
    },
    {
      -- https://vitest.dev/guide/debugging.html#debugging
      type = 'pwa-node',
      request = 'launch',
      name = 'vavite test:unit',
      runtimeExecutable = 'npm',
      runtimeArgs = { 'run', 'test:unit' },
      cwd = '${workspaceFolder}',
    },
    -- {
    --   -- https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_how-do-i-debug-ecmascript-modules
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'ESM',
    --   -- runtimeArgs = { '--experimental-modules' },
    --   -- runtimeArgs = { '-r', 'esm' },
    --   program = '${file}',
    --   cwd = '${workspaceFolder}',
    -- },
    -- {
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'node -r ts-node/register ${file} (Typescript)',
    --   runtimeArgs = { '-r', 'ts-node/register' },
    --   program = '${file}',
    --   cwd = '${workspaceFolder}',
    -- },
    -- {
    --   -- TODO: Way to launch typescript file
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'node --loader ts-node/esm',
    --   -- runtimeExecutable = 'node',
    --   runtimeArgs = { '--loader', 'ts-node/esm' },
    --   port = 9229,
    --   program = '${file}',
    --   cwd = '${workspaceFolder}',
    -- },
    -- {
    --   -- TODO: vite
    --   type = 'node-terminal',
    --   request = 'launch',
    --   runtimeExecutable = 'vavite-loader',
    --   runtimeArgs = { 'vite', 'dev' },
    --   name = '???',
    --   rootPath = '${workspaceFolder}',
    --   cwd = '${workspaceFolder}',
    --   console = 'integratedTerminal',
    -- },
    -- {
    --   -- Launch npm script
    --   -- type = 'node-terminal',
    --   type = 'pwa-node',
    --   request = 'launch',
    --   runtimeExecutable = 'npm',
    --   runtimeArgs = { 'run', 'debug' },
    --   name = 'pwa-node launch npm run debug',
    --   -- port = 9229,
    --   rootPath = '${workspaceFolder}',
    --   cwd = '${workspaceFolder}',
    --   console = 'integratedTerminal',
    --   -- internalConsoleOptions = 'neverOpen',
    -- },
    -- {
    --   -- Launch file
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'pwa-node launch file',
    --   program = '${file}',
    --   cwd = '${workspaceFolder}',
    -- },
    -- {
    --   -- Attach to process
    --   type = 'pwa-node',
    --   request = 'attach',
    --   name = 'pwa-node attach',
    --   processId = require('dap.utils').pick_process,
    --   cwd = '${workspaceFolder}',
    -- },
    -- NOTE: OLDER config
    -- {
    --   -- https://vitest.dev/guide/debugging.html#vscode
    --   -- https://github.com/mxsdev/nvim-dap-vscode-js/issues/19
    --   name = 'vitest (pwa-node)',
    --   type = 'pwa-node',
    --   request = 'launch',
    --   cwd = vim.fn.getcwd(),
    --   program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
    --   args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
    --   autoAttachChildProcesses = true,
    --   smartStep = true,
    --   console = 'integratedTerminal',
    --   skipFiles = { '<node_internals>/**', 'node_modules/**' },
    -- },
    -- {
    --   name = 'SvelteKit',
    --   program = 'npm run dev',
    --   request = 'launch',
    --   type = 'node-terminal',
    -- },
    -- -- https://playwright.dev/docs/debug#playwright-inspector
    -- {
    --   name = 'playwright (pwa-chrome)',
    --   type = 'pwa-chrome',
    --   request = 'launch',
    --   cwd = vim.fn.getcwd(),
    -- },
  }
end
