vim.cmd([[
  autocmd! BufEnter .env* setlocal ft=sh
  autocmd BufEnter */zsh/* setlocal ft=zsh
]])

local ftmap_sh = require('null-ls.builtins._meta.filetype_map').sh
local sh = {
  code_actions = { "shellcheck" },
  diagnostics = { "dotenv_linter", "shellcheck" },
  formatting = { "beautysh", "shellharden", "shfmt" },
  hover = { "printenv" },
}

local ftmap_bash = require('null-ls.builtins._meta.filetype_map').bash
local bash = {
  formatting = { "beautysh" },
}

local ftmap_zsh = require('null-ls.builtins._meta.filetype_map').zsh
local zsh = {
  diagnostics = { "zsh" },
  formatting = { "beautysh" },
}

-- .with({ filetypes = { 'sh', 'bash', 'zsh' } }),
require('null-ls').register({
  require('null-ls.builtins.code_actions.shellcheck'),
  require('null-ls.builtins.diagnostics.dotenv_linter'),
  require('null-ls.builtins.diagnostics.shellcheck'),
  require('null-ls.builtins.diagnostics.zsh'), -- first line only
  require('null-ls.builtins.formatting.beautysh'),
  require('null-ls.builtins.formatting.shellharden'),
  require('null-ls.builtins.formatting.shfmt'),
  require('null-ls.builtins.hover.printenv'),
})

local bashls = require('lspconfig.server_configurations.bashls')
require('lspconfig').bashls.setup({
  filetypes = { 'sh', 'bash', 'zsh' },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
    },
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'all',
    pattern = { '*.sh', '*.bash', '*.zsh' },
    callback = function() vim.lsp.buf.format() end,
  })
