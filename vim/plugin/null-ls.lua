-- https://github.com/ThePrimeagen/refactoring.nvim
require('refactoring').setup({})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
local null_ls = require('null-ls')
null_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  sources = {
    null_ls.builtins.diagnostics.phpstan,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.taplo,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.code_actions.refactoring.with({ filetypes = { 'lua' } }),
    -- -
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.diagnostics.deadnix.with({
      args = { '--no-lambda-arg' },
    }),
    -- null_ls.builtins.code_actions.statix,
    null_ls.builtins.formatting.alejandra,
    -- null_ls.builtins.formatting.nixfmt,
    -- null_ls.builtins.formatting.nixpkgs_fmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.fixjson.with({
      filetypes = { 'json', 'jsonc' },
    }),
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.prettier.with({
      -- extra_filetypes = { 'svelte' },
    }),
    -- null_ls.builtins.formatting.prettier_d_slim.with({
    --   extra_filetypes = { 'svelte' },
    -- }),
    -- null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.shfmt.with({
      filetypes = { 'sh', 'zsh' },
      command = 'shfmt',
      args = { '-filename', '$FILENAME' },
      extra_args = { '-i', '2', '-ci' },
    }),
    null_ls.builtins.formatting.shellharden,
    require('typescript.extensions.null-ls.code-actions'),
  },
  diagnostics_format = 'NLS (#{s}) [#{c}] #{m}',
})
