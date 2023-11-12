-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
require('lspconfig').bashls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
require('lspconfig').clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
-- https://github.com/hrsh7th/vscode-langservers-extracted
require('lspconfig').cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = false,
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
require('lspconfig').marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#psalm
require('lspconfig').psalm.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
require('lspconfig').pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rnix
-- require('lspconfig').rnix.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rls
require('lspconfig').rls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
require('lspconfig').rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
require('lspconfig').sqlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#stylelint_lsp
-- require('lspconfig').stylelint_lsp.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = {
--     'css',
--     'less',
--     'scss',
--     'sugarss',
--     'vue',
--     'wxss',
--     'javascript',
--     'javascriptreact',
--     'typescript',
--     'typescriptreact',
--     'svelte',
--   },
--   root_dir = function()
--     return vim.loop.cwd()
--   end,
-- })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
require('lspconfig').vimls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    diagnostic = {
      enable = true,
    },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
      runtimepath = true,
    },
    isNeovim = true,
    iskeyword = '@,48-57,_,192-255,-#',
    runtimepath = '',
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true,
    },
    vimruntime = '',
  },
  root_dir = root_pattern('runtime', 'nvim', '.git', 'autoload', 'plugin'),
})
