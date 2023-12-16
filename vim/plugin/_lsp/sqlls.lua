local null_ls = require('null-ls')
null_ls.register({
  --- @see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#sql_formatter
  --- @see https://github.com/sql-formatter-org/sql-formatter
  -- null_ls.builtins.formatting.sql_formatter.with({
  --   extra_args = { '-l', 'sqlite' },
  -- }),

  null_ls.builtins.formatting.prettier.with({
    -- https://github.com/nene/prettier-plugin-sql-cst -- NOT WORKING
    -- https://github.com/un-ts/prettier/tree/master/packages/sql#parser-options
    extra_filetypes = { 'sql' },
  }),
})

require('lspconfig').sqlls.setup({
  root_dir = require('lspconfig.util').root_pattern('dev.db'),
})

-- https://www.sqlitetutorial.net/
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
-- https://github.com/joe-re/sql-language-server#configuration
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#sql_formatter
--
-- sql-formatter https://github.com/sql-formatter-org/sql-formatter
-- sqlint https://github.com/joe-re/sql-language-server/tree/release/packages/sqlint#configuration
