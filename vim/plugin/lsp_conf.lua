local root_pattern = require('lspconfig.util').root_pattern

-- https://github.com/ThePrimeagen/refactoring.nvim
require('refactoring').setup({})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#filetypes
local null_ls = require('null-ls')
null_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  sources = {
    null_ls.builtins.diagnostics.phpstan,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.taplo,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.code_actions.refactoring.with({ filetypes = { 'lua' } }),
    -- -
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.diagnostics.deadnix.with({
      args = { '--no-lambda-arg' },
    }),
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.formatting.alejandra,
    -- null_ls.builtins.formatting.nixfmt,
    -- null_ls.builtins.formatting.nixpkgs_fmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.prettierd.with({
      extra_filetypes = { 'svelte' },
    }),
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.shfmt.with({
      filetypes = { 'sh', 'zsh' },
      command = 'shfmt',
      args = { '-filename', '$FILENAME' },
      extra_args = { '-i', '2', '-ci' },
    }),
    null_ls.builtins.formatting.shellharden,
    require('typescript.extensions.null-ls.code-actions'),
  },
  diagnostics_format = 'NLS (#{s}) [#{c}] #{m}',
})

-- https://github.com/folke/neodev.nvim
require('neodev').setup({
  library = {
    enabled = true,
    runtime = true,
    --   types = true,
    plugins = {
      --     'nvim-dap-ui',
      'neotest',
    },
  },
  -- setup_jsonls = true,
  -- override = function(root_dir, library)
  --   if require('neodev.util').has_file(root_dir, '/etc/nixos') then
  --     library.enabled = true
  --     library.plugins = true
  --   end
  -- end,
  -- lspconfig = true,
  -- pathStrict = true,
})
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://github.com/LuaLS/lua-language-server/wiki/Settings
local library = {}
table.insert(library, vim.api.nvim_get_runtime_file('', true))
table.insert(library, '/etc/nixos/vim/neotest')

-- print(vim.inspect(library))

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          '?.lua',
          '?/init.lua',
          '?/?.lua',
        },
        pathStrict = false,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = library,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = 'Replace',
        displayContext = 8,
      },
      format = {
        enable = false,
      },
    },
  },
})

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
require('lspconfig').nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
require('lspconfig').rnix.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

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
