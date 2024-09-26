local wk = require('which-key')
wk.add({
  { '<space>', group = 'LSP' },
  { '<space>a', vim.lsp.buf.code_action, desc = 'code_action', mode = { 'n', 'v' } },
  { '<space>D', vim.lsp.buf.declaration, desc = 'declaration' },
  { '<space>d', vim.lsp.buf.definition, desc = 'definition' },
  { '<space>e', vim.diagnostic.open_float, desc = 'open_float' },
  { '<space>I', vim.lsp.inspect_client, desc = 'inspect_client', noremap = true },
  { '<space>i', vim.lsp.buf.implementation, desc = 'implementation' },
  { '<space>O', [[<cmd>LspOverloadsSignature<CR>]] },
  { '<space>o', [[<cmd>Outline<CR>]] },
  { '<space>q', vim.diagnostic.setloclist, desc = 'setloclist' },
  { '<space>R', vim.lsp.buf.references, desc = 'references' },
  { '<space>r', vim.lsp.buf.rename, desc = 'rename' },
  { '<space>S', require('lsp_signature').toggle_float_win, desc = 'toggle_float_win' },
  { '<space>s', vim.lsp.buf.signature_help, desc = 'signature_help' },
  { '<space>t', vim.lsp.buf.type_definition, desc = 'type_definition' },
})

require('goto-preview').setup({})
wk.add({
  { '<leader>p', group = 'goto-preview' },
  { '<leader>pd', require('goto-preview').goto_preview_definition, desc = 'definition' },
  { '<leader>pt', require('goto-preview').goto_preview_type_definition, desc = 'type_definition' },
  { '<leader>pi', require('goto-preview').goto_preview_implementation, desc = 'implementation' },
  { '<leader>pD', require('goto-preview').goto_preview_declaration, desc = 'declaration' },
  { '<leader>pc', require('goto-preview').close_all_win, desc = 'close_all_win' },
  { '<leader>pr', require('goto-preview').goto_preview_references, desc = 'references' },
})
vim.lsp.inspect_client = function()
  local function get_keys(t)
    local keys = {}
    for key, _ in pairs(t) do
      table.insert(keys, key)
    end
    return keys
  end
  local pretty = require('pl.pretty')
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  vim.ui.select(clients, {
    prompt = 'Select LSP client',
    format_item = function(client)
      return client.name
    end,
  }, function(selected_client)
    if selected_client then
      local client = vim.lsp.get_client_by_id(selected_client.id)
      local keys = get_keys(client)

      vim.ui.select(keys, {}, function(key)
        if key and client ~= nil and client[key] then
          pretty(client[key])
        else
          pretty(client)
        end
      end)
    end
  end)
end
local ftmap = require('null-ls.builtins._meta.filetype_map')
local nls = require('null-ls')
nls.setup({
  sources = {
    nls.builtins.formatting.stylua,
  },
  diagnostics_format = '#{m} [#{c}] (#{s}) null-ls',
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local c = require('lspconfig')

c.clangd.setup({})
c.cssls.setup({
	capabilities = capabilities,
})
c.gopls.setup({})
c.templ.setup({})
c.stylelint_lsp.setup({
  capabilities = capabilities,
  filetypes = { 'css' },
  settings = {
    stylelintplus = {
      enable = true,
      autoFixOnFormat = true,
    },
  },
})
nls.register({ nls.builtins.formatting.prettierd.with({ filetypes = { 'html', 'twig' } }) })
c.html.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'templ', 'twig' },
})
c.htmx.setup({ filetypes = { 'html', 'templ', 'twig' } })
local ls = require('luasnip')
ls.filetype_extend('twig', { 'html' })
ls.filetype_extend('html', { 'twig' })
c.twiggy_language_server.setup({
  cmd = { 'node', '/etc/nixos/node_modules/twiggy-language-server/dist/server.js', '--stdio' },
  filetypes = { 'html', 'templ', 'twig' },
})
nls.register({
  nls.builtins.formatting.markdownlint,
})
c.marksman.setup({})
c.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas({
        extra = {
          {
            fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
            name = 'snippets',
            url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
          },
        },
      }),
      validate = { enable = true },
    },
  },
})

c.nixd.setup({
  settings = {
    nixd = {
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },
})
c.nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = { command = { 'nixfmt' } },
      nix = {
        maxMemoryMB = 20480,
        flake = {
          -- autoArchive = true,
          -- autoEvalInputs = true,
          nixpkgsInputName = 'nixpkgs',
        },
      },
    },
  },
})
c.intelephense.setup({})
nls.register({ nls.builtins.formatting.black })
c.pyright.setup({})
c.rust_analyzer.setup({})

nls.register({
  nls.builtins.diagnostics.dotenv_linter,
  nls.builtins.diagnostics.zsh,
  nls.builtins.formatting.shellharden,
  nls.builtins.formatting.shfmt,
  nls.builtins.hover.printenv,
})
c.bashls.setup({
  filetypes = { 'sh', 'bash', 'zsh' },
  settings = { bashIde = { globPattern = '*@(.sh|.inc|.bash|.command|.zsh)' } },
})
nls.register({
  nls.builtins.diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'sqlite' } }),
})
-- local sqlls = require('lspconfig.server_configurations.sqlls')
-- require('lspconfig').sqlls.setup({
--   cmd = { './node_modules/.bin/sql-language-server', 'up', '--method', 'stdio' },
-- })
-- local sqls = require('lspconfig.server_configurations.sqls')
-- require('lspconfig').sqls.setup({ cmd = { "sqls", "-config", "/etc/nixos/sql/.sqls.yml" } })
-- https://github.com/supabase/postgres_lsp
-- local postgres_lsp = require('lspconfig.server_configurations.postgres_lsp')
-- require('lspconfig').postgres_lsp.setup({})
nls.register({ nls.builtins.diagnostics.vint })
c.vimls.setup({})
c.yamlls.setup({
  settings = {
    yaml = { format = { enable = true } },
    schemaStore = {
      enable = false,
      url = '',
    },
    schemas = require('schemastore').yaml.schemas(),
  },
})
c.taplo.setup({})
c.zls.setup({})
