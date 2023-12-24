local root_pattern = require('lspconfig.util').root_pattern

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
