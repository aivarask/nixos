local ftmap = require('null-ls.builtins._meta.filetype_map').html
local html_map = {
  diagnostics = { "markuplint", "tidy" },
  formatting = { "prettier", "prettierd", "rustywind", "tidy" },
}

require('null-ls').register({
  require('null-ls.builtins.formatting.prettierd').with({ filetypes = { 'html', 'twig' } }),
  -- require('null-ls.builtins.formatting.tidy').with({ filetypes = { 'xml', 'twig' } }),
  -- require('null-ls.builtins.diagnostics.tidy').with({ filetypes = { 'xml', 'twig' } }),
})

local html = require('lspconfig.server_configurations.html')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').html.setup({
  capabilities = capabilities,
  filetypes = {
    'html',
    'templ',
    'twig',
  },
})

local htmx = require('lspconfig.server_configurations.htmx')
require('lspconfig').htmx.setup({
  filetypes = { 'html', 'templ', 'twig' },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'null-ls prettierd',
    pattern = { '*.html', '*.xml' },
    callback = function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client) return client.name == "null-ls" end,
      })
    end,
  })

local ftmap_twig = require('null-ls.builtins._meta.filetype_map').twig
local twig = { diagnostics = { "twigcs" } }
-- https://github.com/moetelo/twiggy
local twiggy = require('lspconfig.server_configurations.twiggy_language_server')
require('lspconfig').twiggy_language_server.setup({
  cmd = { 'node', '/etc/nixos/node_modules/twiggy-language-server/dist/server.js', '--stdio' },
  filetypes = {
    'html',
    'templ',
    'twig',
  },
})
require('luasnip').filetype_extend('twig', { 'html' })
require('luasnip').filetype_extend('html', { 'twig' })

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'null-ls prettierd',
    pattern = { '*.twig' },
    callback = function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end,
  })

local emmet_ls = require('lspconfig.server_configurations.emmet_ls')
-- local emmet_ls_capabilities = vim.lsp.protocol.make_client_capabilities()
-- emmet_ls_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- require('lspconfig').emmet_ls.setup({
--   capabilities = emmet_ls_capabilities,
--   init_options = {
--     html = {
--       options = {
--         ["bem.enabled"] = true,
--       },
--     },
--   },
-- })

local emmet_language_server = require('lspconfig.server_configurations.emmet_language_server')
-- require('lspconfig').emmet_language_server.setup({})
