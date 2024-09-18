local ftmap = require "null-ls.builtins._meta.filetype_map"
local nls = require "null-ls"
nls.setup {
	sources = {
	nls.builtins.formatting.stylua,
	},
	diagnostics_format = "#{m} [#{c}] (#{s}) null-ls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local c = require "lspconfig"

c.clangd.setup {}
c.gopls.setup {}
c.templ.setup {}
c.cssls.setup {
	capabilities = capabilities,
}
c.stylelint_lsp.setup {
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
c.html.setup {
	capabilities = capabilities,
	filetypes = { "html", "templ", "twig", },
}
c.htmx.setup { filetypes = { "html", "templ", "twig", }, }
local ls = require "luasnip"
ls.filetype_extend("twig", { "html", })
ls.filetype_extend("html", { "twig", })
c.twiggy_language_server.setup {
	cmd = { "node", "/etc/nixos/node_modules/twiggy-language-server/dist/server.js", "--stdio", },
	filetypes = { "html", "templ", "twig", },
}
nls.register {
	nls.builtins.formatting.markdownlint,
}
c.marksman.setup {}
c.jsonls.setup {
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

c.nixd.setup {
	settings = {
		nixd = {
			formatting = {
				command = { "nixfmt", },
			},
		},
	},
}
c.nil_ls.setup {
	settings = {
		["nil"] = {
			formatting = { command = { "nixfmt", }, },
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
c.intelephense.setup {}
nls.register { nls.builtins.formatting.black, }
c.pyright.setup {}
c.rust_analyzer.setup {}

nls.register {
	nls.builtins.diagnostics.dotenv_linter,
	nls.builtins.diagnostics.zsh,
	nls.builtins.formatting.shellharden,
	nls.builtins.formatting.shfmt,
	nls.builtins.hover.printenv,
}
c.bashls.setup {
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
c.vimls.setup {}
c.yamlls.setup {
	settings = {
		yaml = { format = { enable = true, }, },
		schemaStore = {
			enable = false,
			url = "",
		},
		schemas = require "schemastore".yaml.schemas(),
	},
}
c.taplo.setup {}
c.zls.setup {}
