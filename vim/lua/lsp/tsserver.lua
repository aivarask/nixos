require("lspconfig").tsserver.setup({
  init_options = require("nvim-lsp-ts-utils").init_options,
  capabilities = require("capabilities"),
  on_attach = require("on_attach"),
  flags = require("flags"),
})
