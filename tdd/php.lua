require('dap').adapters.php = { -- https://github.com/xdebug/vscode-php-debug
  type = 'executable',
  command = 'node',
  args = { '/root/vscode-php-debug/out/phpDebug.js' },
}

require('dap').configurations.php = { -- https://github.com/xdebug/vscode-php-debug#vs-code-configuration
  {
    type = 'php',
    request = 'launch',
    name = 'localhost:8000',
    port = 9003,
    runtimeArgs = { '-S', 'localhost:8000', '-c=php.ini', '-t=fp' },
  },
  {
    type = "php",
    request = "launch",
    name = "php launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "php",
    request = "launch",
    name = "php",
    port = 9003,
    stopOnEntry = false,
    xdebugSettings = {
      max_children = 512,
      max_data = 1024,
      max_depth = 4,
    },
    breakpoints = {
      exception = {
        Notice = false,
        Warning = false,
        Error = false,
        Exception = false,
        ["*"] = false,
      },
    },
  },
}
