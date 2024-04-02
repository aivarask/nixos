local ftmap = require('null-ls.builtins._meta.filetype_map').php
local php = {
  diagnostics = { "php", "phpcs", "phpmd", "phpstan", "psalm" },
  formatting = { "phpcbf", "phpcsfixer", "pint", "pretty_php" },
}

require('lspconfig').intelephense.setup({
  root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'index.php'),
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'Format',
  desc = 'intelephense',
  pattern = { '*.php' },
  callback = function() vim.lsp.buf.format() end,
})

require('dap').defaults.fallback.switchbuf = "useopen"
require('dap').adapters.php = { -- https://github.com/xdebug/vscode-php-debug
  type = 'executable',
  command = 'node',
  args = { '/root/vscode-php-debug/out/phpDebug.js' },
}

require('dap').configurations.php = { -- https://github.com/xdebug/vscode-php-debug#vs-code-configuration
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
  {
    type = 'php',
    request = 'launch',
    name = 'localhost:8000',
    port = 9003,
    runtimeArgs = { '-S', 'localhost:8000', '-c=php.ini', '-t=src' },
  },
}
