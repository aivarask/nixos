require('lspconfig').sqlls.setup({})

local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.formatting.sql_formatter,
})

-- https://www.sqlitetutorial.net/
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
-- https://github.com/joe-re/sql-language-server#configuration
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#sql_formatter
--
-- sql-formatter https://github.com/sql-formatter-org/sql-formatter
-- sqlint https://github.com/joe-re/sql-language-server/tree/release/packages/sqlint#configuration
