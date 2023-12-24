vim.filetype.add({
  extension = {
    templ = 'templ',
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.templ' },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})

local null_ls = require('null-ls')
null_ls.register({
  sources = {
    -- null_ls.builtins.formatting.gofmt
    -- null_ls.builtins.formatting.gofumpt,
    -- null_ls.builtins.formatting.goimports_reviser,
    -- null_ls.builtins.formatting.golines,
    -- null_ls.builtins.formatting.templ,
    -- https://makefiletutorial.com/#targets
    -- https://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile
    -- https://github.com/mrtazz/checkmake
    -- null_ls.builtins.diagnostics.checkmake,
  },
})
require('lspconfig').gopls.setup({})
require('lspconfig').templ.setup({})
