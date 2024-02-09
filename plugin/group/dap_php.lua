local dap = require('dap')
-- https://www.oliverdavies.uk/blog/debugging-php-docker-xdebug-neovim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#php
-- https://github.com/xdebug/vscode-php-debug#installation

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/root/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
  -- https://github.com/xdebug/vscode-php-debug#supported-launchjson-settings
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    program = '${file}',

    -- port = 9003,
  },
}
