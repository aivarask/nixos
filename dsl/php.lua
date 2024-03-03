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

-- https://github.com/xdebug/vscode-php-debug
require('dap').adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/root/vscode-php-debug/out/phpDebug.js' },
}

-- https://github.com/xdebug/vscode-php-debug#vs-code-configuration
require('dap').configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Launch',
    -- port = 9000,
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
