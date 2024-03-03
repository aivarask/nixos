local ftmap = require('null-ls.builtins._meta.filetype_map').markdown
local markdown = {
  code_actions = { "ltrs", "proselint" },
  diagnostics = { "alex", "ltrs", "ltrs", "markdownlint", "markdownlint_cli2", "mdl", "proselint", "textidote", "textlint", "vale", "write_good" },
  formatting = { "cbfmt", "deno_fmt", "dprint", "markdown_toc", "markdownlint", "mdformat", "ocdc", "prettier", "prettierd", "remark", "terrafmt", "textlint" },
  hover = { "dictionary" },
}
require('null-ls').register({
  -- require('null-ls.builtins.formatting.mdformat'),
  require('null-ls.builtins.formatting.markdownlint'),
})

local marksman = require('lspconfig.server_configurations.marksman')
require('lspconfig').marksman.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'markdownlint',
    pattern = { '*.md' },
    callback = function() vim.lsp.buf.format() end,
  })
