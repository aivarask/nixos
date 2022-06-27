local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
  cmd = { "lua-language-server" },
  capabilities = require("capabilities"),
  on_attach = require("on_attach"),
  flags = require("flags"),
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = runtime_path },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
        preloadFileSize = 2000,
      },
      telemetry = { enable = false },
    },
  },
})
