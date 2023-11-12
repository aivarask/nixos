-- ISSUE:
-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
-- https://github.com/neovim/nvim-lspconfig/issues/725
-- https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode
-- https://github.com/sveltejs/language-tools/tree/master/packages/typescript-plugin

local choise = 1

local function rename_file() -- https://github.com/neovim/neovim/issues/20784#issuecomment-1288085253
  local source_file, target_file

  vim.ui.input({
    prompt = 'Source : ',
    completion = 'file',
    default = vim.api.nvim_buf_get_name(0),
  }, function(input)
    source_file = input
  end)
  vim.ui.input({
    prompt = 'Target : ',
    completion = 'file',
    default = source_file,
  }, function(input)
    target_file = input
  end)

  local params = {
    command = '_typescript.applyRenameFile',
    arguments = {
      {
        sourceUri = source_file,
        targetUri = target_file,
      },
    },
    title = '',
  }

  vim.lsp.util.rename(source_file, target_file, nil)
  vim.lsp.buf.execute_command(params)
end

if choise == 1 then
  -- print('Init lspconfig_tsserver')
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
  require('lspconfig').tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      -- 'svelte',
      'javascript',
      -- 'javascriptreact',
      -- 'javascript.jsx',
      'typescript',
      -- 'typescriptreact',
      -- 'typescript.tsx',
    },
    commands = {
      RenameFile = {
        rename_file,
        description = 'Rename File',
      },
    },
  })
elseif choise == 2 then
  -- print('Init typescript.nvim')
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
elseif choise == 3 then
  -- print('Init typescript-tools')
  -- https://github.com/pmizio/typescript-tools.nvim
  require('typescript-tools').setup({
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = {
      ['workspace/willRenameFiles'] = function(ctx)
        print(ctx)
      end,
    },
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = 'insert_leave',
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
      -- "remove_unused_imports"|"organize_imports") -- or string "all"
      -- to include all supported code actions
      -- specify commands exposed as code_actions
      expose_as_code_action = {},
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = 'auto',
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = {},
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = false,
    },
  })
end
