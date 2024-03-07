local ftmap = require('null-ls.builtins._meta.filetype_map').html
local html_map = {
  diagnostics = { "markuplint", "tidy" },
  formatting = { "prettier", "prettierd", "rustywind", "tidy" },
}

local html = require('lspconfig.server_configurations.html')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').html.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'templ', 'twig' },
})

local htmx = require('lspconfig.server_configurations.htmx')
require('lspconfig').htmx.setup({})

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


vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'html',
    pattern = { '*.html' },
    callback = function() vim.lsp.buf.format() end,
  })

local twig = require('null-ls.builtins._meta.filetype_map').twig
-- https://github.com/moetelo/twiggy
local twiggy = require('lspconfig.server_configurations.twiggy_language_server')
require('lspconfig').twiggy_language_server.setup({
  -- cmd = { 'node', '/root/.pnpm-global/global/5/node_modules/twiggy-language-server/dist/server.js', '--stdio' },
  cmd = { 'node', '/etc/nixos/node_modules/twiggy-language-server/dist/server.js', '--stdio' },
})
-- require('luasnip').filetype_extend('twig', { 'html' })

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'twig',
    pattern = { '*.twig' },
    callback = function() vim.lsp.buf.format() end,
  })
