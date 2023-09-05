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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssmodules_ls
-- https://github.com/antonk52/cssmodules-language-server
require('lspconfig').cssmodules_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte' },
})

-- https://github.com/aca/emmet-ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls
require('lspconfig').emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function()
    return vim.loop.cwd()
  end,
  init_options = {
    ['bem.enabled'] = true,
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
require('lspconfig').marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
-- https://github.com/oxalica/nil/blob/main/docs/configuration.md
require('lspconfig').nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['nil'] = {
      testSetting = 42,
      formatting = {
        command = { 'alejandra' },
      },
      flake = { autoEvalInputs = true },
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#psalm
require('lspconfig').psalm.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#prismals
require('lspconfig').prismals.setup({
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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte
-- https://github.com/sveltejs/language-tools/tree/master/packages/typescript-plugin
require('lspconfig').svelte.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
require('lspconfig').tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,

  -- https://github.com/tailwindlabs/tailwindcss-intellisense#extension-settings
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      classAttributes = {
        'class',
        'class:',
        'className',
        'classWrap',
        'classInput',
        'classText',
        'classAvatar',
        'classList',
        'divClass',
        'navClass',
        'navDivClass',
        'ulClass',
      },
      validate = true,
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
-- require('lspconfig').tsserver.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
-- https://github.com/jose-elias-alvarez/typescript.nvim#setup
require('typescript').setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      -- 'svelte',
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
  },
})

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

-- https://github.com/SchemaStore/schemastore
-- https://github.com/b0o/SchemaStore.nvim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    provideFormatter = false,
  },
  settings = {
    format = { enable = true },
    json = {
      schemas = vim.list_extend(require('schemastore').json.schemas({}), {
        {
          description = 'Schema for code snippet files in visual studio code extensions',
          fileMatch = { 'snippets/*.json' },
          name = 'Snippets',
          url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
        },
      }),
      validate = { enable = true },
    },
  },
})
