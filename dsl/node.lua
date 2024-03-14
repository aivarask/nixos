local ftmap = require('null-ls.builtins._meta.filetype_map').javascript
local javascript = {
  code_actions = { "eslint", "eslint_d", "refactoring", "xo" },
  diagnostics = { "deno_lint", "eslint", "eslint_d", "jshint", "semistandardjs", "standardjs", "xo" },
  formatting = { "biome", "deno_fmt", "dprint", "eslint", "eslint_d", "prettier", "prettierd", "rustywind", "semistandardjs", "standardjs" },
}

local biome = require('lspconfig.server_configurations.biome')
-- require('lspconfig').biome.setup({})

local tsserver = require('lspconfig.server_configurations.tsserver')
require('lspconfig').tsserver.setup({
  -- filetypes = { 'javascript', 'html' }
})
vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'tsserver',
    pattern = { '*.js', '*.ts' },
    callback = function() vim.lsp.buf.format() end,
  })

-- nvim-dap-vscode-js
require("dap-vscode-js").setup({
  debugger_path = "/root/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})
for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
