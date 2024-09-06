vim.api.nvim_create_augroup("Format", { clear = true, })
ftmap = require "null-ls.builtins._meta.filetype_map"

nls = require "null-ls"
require "null-ls".setup {
  sources = { nls.builtins.code_actions.refactoring, },
  diagnostics_format = "#{m} [#{c}] (#{s}) null-ls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig = require "lspconfig"
lspconfig.clangd.setup {}
vim.filetype.add { extension = { templ = "templ", }, }
lspconfig.gopls.setup {}
lspconfig.templ.setup {}
lspconfig.cssls.setup {
  capabilities = capabilities,
}
lspconfig.stylelint_lsp.setup {
  capabilities = capabilities,
  filetypes = { "css", },
  settings = {
    stylelintplus = {
      enable = true,
      autoFixOnFormat = true,
    },
  },
}
nls.register { nls.builtins.formatting.prettierd.with { filetypes = { "html", "twig", }, }, }
lspconfig.html.setup {
  capabilities = capabilities,
  filetypes = { "html", "templ", "twig", },
}
lspconfig.htmx.setup { filetypes = { "html", "templ", "twig", }, }
require "luasnip".filetype_extend("twig", { "html", })
require "luasnip".filetype_extend("html", { "twig", })
lspconfig.twiggy_language_server.setup {
  cmd = { "node", "/etc/nixos/node_modules/twiggy-language-server/dist/server.js", "--stdio", },
  filetypes = { "html", "templ", "twig", },
}
nls.register {
  nls.builtins.formatting.markdownlint,
}
lspconfig.marksman.setup {}

vim.cmd [[ autocmd! BufEnter *.json,flake.lock,.prettierrc setlocal ft=jsonc ]]
lspconfig.jsonls.setup {
  capabilities = capabilities,
  settings = { json = {
    schemas = require "schemastore".json.schemas {
      extra = {
        {
          fileMatch = { "*/snippets/*.json", "!*/snippets/package.json", },
          name = "snippets",
          url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json",
        },
      },
    },
    validate = { enable = true, },
  },
  },
}

lspconfig.nil_ls.setup {
  autostart = true,
  settings = {
    ["nil"] = {
      formatting = { command = { "nixpkgs-fmt", }, },
      nix = {
        maxMemoryMB = 20480,
        flake = {
          -- autoArchive = true,
          -- autoEvalInputs = true,
          nixpkgsInputName = "nixpkgs",
        },
      },
    },
  },
}
lspconfig.intelephense.setup {}
nls.register { nls.builtins.formatting.black, }
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}

vim.cmd [[
  autocmd! BufEnter .env* setlocal ft=sh
  autocmd BufEnter */zsh/* setlocal ft=zsh
]]
nls.register {
  nls.builtins.diagnostics.dotenv_linter,
  nls.builtins.diagnostics.zsh,
  nls.builtins.formatting.shellharden,
  nls.builtins.formatting.shfmt,
  nls.builtins.hover.printenv,
}
lspconfig.bashls.setup {
  filetypes = { "sh", "bash", "zsh", },
  settings = { bashIde = { globPattern = "*@(.sh|.inc|.bash|.command|.zsh)", }, },
}
nls.register {
  nls.builtins.diagnostics.sqlfluff.with { extra_args = { "--dialect", "sqlite", }, },
}
-- local sqlls = require('lspconfig.server_configurations.sqlls')
-- require('lspconfig').sqlls.setup({
--   cmd = { './node_modules/.bin/sql-language-server', 'up', '--method', 'stdio' },
-- })
-- local sqls = require('lspconfig.server_configurations.sqls')
-- require('lspconfig').sqls.setup({ cmd = { "sqls", "-config", "/etc/nixos/sql/.sqls.yml" } })
-- https://github.com/supabase/postgres_lsp
-- local postgres_lsp = require('lspconfig.server_configurations.postgres_lsp')
-- require('lspconfig').postgres_lsp.setup({})
nls.register { nls.builtins.diagnostics.vint, }
lspconfig.vimls.setup {}
lspconfig.yamlls.setup {
  settings = {
    yaml = { format = { enable = true, }, },
    schemaStore = {
      enable = false,
      url = "",
    },
    schemas = require "schemastore".yaml.schemas(),
  },
}
lspconfig.zls.setup {}
