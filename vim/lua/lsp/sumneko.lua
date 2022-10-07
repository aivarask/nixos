-- https://github.com/folke/lua-dev.nvim
require('lua-dev').setup({})
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require('lspconfig').sumneko_lua.setup({
  capabilities = require("capabilities"),
  on_attach = require("on_attach"),
  flags = require("flags"),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = '?/init.lua'
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        -- maxPreload = 1000,
        -- preloadFileSize = 10000,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        enable = true,
        callSnippet = "Replace",
      },
    },
  },
})
