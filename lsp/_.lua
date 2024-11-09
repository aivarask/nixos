-- vim:foldlevel=3

require('genghis').setup({
	backdrop = {
		enabled = true,
		blend = 50,
	},
	-- default is `"trash"` on Mac/Windows, and `{ "gio", "trash" }` on Linux
	trashCmd = 'trash',
})
gen = require('genghis')
require('lsp-file-operations').setup({})

require('null-ls').setup()
require('outline').setup({
	outline_window = {
		position = 'right',
		width = 20,
	},
	symbols = {
		icons = {
			Class = { icon = '󰠱', hl = 'Type' },
			String = { icon = '󰉿', hl = 'String' },
			Struct = { icon = '󰙅', hl = 'Structure' },
			Event = { icon = '', hl = 'Type' },
			TypeParameter = { icon = 'T', hl = 'Identifier' },
		},
	},
	symbol_folding = {
		autofold_depth = 1,
		auto_unfold = {
			hovered = false,
			only = true,
		},
	},
	preview_window = {
		auto_preview = false,
	},
})
require('goto-preview').setup({})
require('which-key').add({
	{ '<space>', group = 'LSP' },
	{ '<space>a', vim.lsp.buf.code_action, desc = 'code_action', mode = { 'n', 'v' } },
	{ '<space>D', vim.lsp.buf.declaration, desc = 'declaration' },
	{ '<space>dd', vim.lsp.buf.definition, desc = 'definition' },
	{ '<space>e', vim.diagnostic.open_float, desc = 'open_float' },
	{ '<space>i', vim.lsp.buf.implementation, desc = 'implementation' },
	{ '<space>O', [[<cmd>LspOverloadsSignature<CR>]] },
	{ '<space>o', [[<cmd>Outline<CR>]] },
	{ '<space>p', group = 'goto-preview' },
	{ '<space>pd', require('goto-preview').goto_preview_definition, desc = 'definition' },
	{ '<space>pt', require('goto-preview').goto_preview_type_definition, desc = 'type_definition' },
	{ '<space>pi', require('goto-preview').goto_preview_implementation, desc = 'implementation' },
	{ '<space>pD', require('goto-preview').goto_preview_declaration, desc = 'declaration' },
	{ '<space>pc', require('goto-preview').close_all_win, desc = 'close_all_win' },
	{ '<space>pr', require('goto-preview').goto_preview_references, desc = 'references' },
	{ '<space>q', vim.diagnostic.setloclist, desc = 'setloclist' },
	{ '<space>r', vim.lsp.buf.references, desc = 'references' },
	{ '<space>R', vim.lsp.buf.rename, desc = 'rename' },
	{ '<space>s', vim.lsp.buf.signature_help, desc = 'signature_help' },
	{ '<c-b>', vim.lsp.buf.signature_help, desc = 'signature_help', mode = { 'i' } },
	{ '<space>t', vim.lsp.buf.type_definition, desc = 'type_definition' },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

if false then
	vim.lsp.log.set_level(vim.lsp.log_levels.INFO)
	vim.lsp.log.set_format_func(vim.inspect)
end
vim.api.nvim_create_autocmd('Filetype', {
	pattern = { 'javascript', 'typescript' },
	callback = function()
		vim.lsp.start({
			name = 'lsjs',
			cmd = { 'ls.js' },
			root_dir = vim.fs.root(0, { 'package.json' }),
			-- capabilities = capabilities,
		})
		vim.lsp.start({
			name = 'tsls',
			-- https://github.com/microsoft/TypeScript
			-- https://github.com/typescript-language-server/typescript-language-server
			cmd = { '/etc/nixos/node_modules/.bin/typescript-language-server', '--stdio' },
			root_dir = vim.fs.root(0, { 'package.json' }),
			init_options = { hostInfo = 'neovim' },
			-- capabilities = capabilities,
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.js', '*.ts' },
	desc = 'format tsls',
	callback = function()
		vim.lsp.buf.format({ name = 'tsls' })
	end,
})

require('null-ls').register({ require('null-ls.builtins.diagnostics.vint') })
vim.api.nvim_create_autocmd('Filetype', {
	pattern = { 'vim' },
	callback = function(ev)
		vim.lsp.start({
			name = 'vimls',
			cmd = { 'vim-language-server', '--stdio' },
			root_dir = vim.fs.root(ev.buf, { 'flake.lock' }),
			init_options = {
				isNeovim = true,
				iskeyword = '@,48-57,_,192-255,-#',
				vimruntime = '',
				runtimepath = '',
				diagnostic = { enable = true },
				indexes = {
					runtimepath = true,
					gap = 100,
					count = 3,
					projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
				},
				suggest = { fromVimruntime = true, fromRuntimepath = true },
			},
		})
	end,
})

vim.api.nvim_create_autocmd('Filetype', {
	pattern = { 'markdown', 'markdown.mdx' },
	callback = function()
		vim.lsp.start({
			cmd = { 'marksman', 'server' },
		})
	end,
})
require('null-ls').register({
	require('null-ls.builtins.formatting.markdownlint'),
	require('null-ls.builtins.diagnostics.markdownlint'),
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.md', '*.mdx' },
	desc = 'format markdownlint',
	callback = function()
		vim.lsp.buf.format({ name = 'null-ls' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
	callback = function()
		vim.lsp.start({ cmd = { 'clangd' } })
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.c', '*.cpp' },
	desc = 'format clangd',
	callback = function()
		vim.lsp.buf.format({ name = 'clangd' })
	end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'css', 'scss', 'less' },
	desc = 'lsp stylelint',
	callback = function()
		vim.lsp.start({
			cmd = { 'stylelint-lsp', '--stdio' },
			capabilities = capabilities,
			settings = {
				stylelintplus = {
					enable = true,
					autoFixOnFormat = true,
					autoFixOnSave = true,
				},
			},
		})
		vim.lsp.start({
			cmd = { 'vscode-css-language-server', '--stdio' },
			capabilities = capabilities,
			init_options = { provideFormatter = true },
			settings = {
				css = { validate = true },
				scss = { validate = true },
				less = { validate = true },
			},
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.css', '*.scss', '*.less' },
	desc = 'format vscode-css-language-server',
	callback = function()
		vim.lsp.buf.format({ name = 'vscode-css-language-server' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'php' },
	desc = 'lsp intelephense',
	callback = function()
		vim.lsp.start({
			cmd = { 'intelephense', '--stdio' },
			filetypes = { 'php' },
			settings = {
				intelephense = {
					files = {
						maxSize = 1000000,
					},
				},
			},
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.php' },
	desc = 'format intelephense',
	callback = function()
		vim.lsp.buf.format({ name = 'intelephense' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python' },
	desc = 'lsp pyright',
	callback = function()
		vim.lsp.start({
			cmd = { 'pyright-langserver', '--stdio' },
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = 'openFilesOnly',
					},
				},
			},
		})
	end,
})
require('null-ls').register({ require('null-ls.builtins.formatting.black') })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.py' },
	desc = 'format black',
	callback = function()
		vim.lsp.buf.format({ name = 'null-ls' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'zig', 'zir' },
	desc = 'lsp zig',
	callback = function()
		vim.lsp.start({
			cmd = { 'zls' },
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.zig' },
	desc = 'format zls',
	callback = function()
		vim.lsp.buf.format({ name = 'zls' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'toml' },
	desc = 'lsp taplo',
	callback = function()
		vim.lsp.start({
			cmd = { 'taplo', 'lsp', '-c', '/etc/nixos/.taplo.toml', 'stdio' },
			root_dir = '/etc/nixos',
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.toml' },
	desc = 'format taplo not working',
	callback = function()
		vim.lsp.buf.format({ name = 'taplo' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'rust' },
	desc = 'lsp rust_analyzer',
	callback = function()
		vim.lsp.start({ cmd = { 'rust-analyzer' } })
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.rs' },
	desc = 'format rust-analyzer',
	callback = function()
		vim.lsp.buf.format({ name = 'rust-analyzer' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'go', 'gomod', 'gowork', 'gotmpl' },
	desc = 'lsp gopls',
	callback = function()
		vim.lsp.start({ cmd = { 'gopls' } })
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.go' },
	desc = 'format gopls',
	callback = function()
		vim.lsp.buf.format({ name = 'gopls' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'templ' },
	desc = 'lsp templ',
	callback = function()
		vim.lsp.start({ cmd = { 'templ', 'lsp' } })
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.templ' },
	desc = 'format templ',
	callback = function()
		vim.lsp.buf.format({ name = 'templ' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'json', 'jsonc' },
	desc = 'lsp vscode-json-language-server',
	callback = function()
		vim.lsp.start({
			cmd = { 'vscode-json-language-server', '--stdio' },
			capabilities = capabilities,
			settings = {
				json = {
					validate = { enable = true },
					format = { enable = true },
					schemas = require('schemastore').json.schemas({
						extra = {
							{
								fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
								name = 'snippets',
								url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
							},
						},
					}),
				},
			},
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.json', '*.jsonc' },
	desc = 'format vscode-json-language-server',
	callback = function()
		vim.lsp.buf.format({ name = 'vscode-json-language-server' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'yaml' },
	desc = 'lsp yamlls',
	callback = function()
		vim.lsp.start({
			cmd = { 'yaml-language-server', '--stdio' },
			settings = {
				-- https://github.com/redhat-developer/yaml-language-server#language-server-settings
				yaml = {
					format = { enable = true },
					schemaStore = { enable = true },
					schemas = require('schemastore').yaml.schemas(),
				},
			},
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.yaml', '*.yml' },
	desc = 'format yamlls',
	callback = function()
		vim.lsp.buf.format({ name = 'yaml-language-server' })
	end,
})

require('null-ls').register({
	require('null-ls.builtins.formatting.sqlfluff').with({ extra_args = { '--dialect', 'sqlite' } }),
	require('null-ls.builtins.diagnostics.sqlfluff').with({ extra_args = { '--dialect', 'sqlite' } }),
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.sql' },
	desc = 'format sqlfluff',
	callback = function()
		vim.lsp.buf.format({ name = 'null-ls' })
	end,
})
-- local sqlls = require('lspconfig.server_configurations.sqlls')
-- require('lspconfig').sqlls.setup({
--   cmd = { './node_modules/.bin/sql-language-server', 'up', '--method', 'stdio' },
-- })
-- local sqls = require('lspconfig.server_configurations.sqls')
-- require('lspconfig').sqls.setup({ cmd = { "sqls", "-config", "/etc/nixos/sql/.sqls.yml" } })
-- https://github.com/supabase/postgres_lsp
-- local postgres_lsp = require('lspconfig.server_configurations.postgres_lsp')
-- require('lspconfig').postgres_lsp.setup({})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'nix',
	callback = function(ev)
		vim.lsp.start({
			name = 'nixd',
			cmd = { 'nixd' },
			root_dir = vim.fs.root(ev.buf, { 'flake.lock' }),
			settings = {
				nixd = {
					formatting = { command = { 'nixfmt' } },
					nixpkgs = { expr = 'import <nixpkgs> { }' },
					options = {
						nixos = {
							expr = '(builtins.getFlake ("git+file://" + toString /etc/nixos)).nixosConfigurations.dell.options',
						},
						home_manager = {
							expr = '(builtins.getFlake ("git+file://" + toString /etc/nixos)).homeConfigurations.root.options',
						},
					},
				},
			},
		})
	end,
})
require('null-ls').register({ require('null-ls.builtins.formatting.nixfmt') })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.nix' },
	desc = 'null-ls',
	callback = function()
		vim.lsp.buf.format({ name = 'null-ls' })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'sh', 'bash', 'zsh' },
	callback = function()
		vim.lsp.start({
			name = 'bash-language-server',
			cmd = { 'bash-language-server', 'start' },
			settings = {
				bashIde = {
					globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
					-- shellcheckArguments = { '--shell=bash' },
				},
			},
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.sh', '*.bash', '*.zsh' },
	desc = 'vim.lsp.buf.format bash-language-server 1000',
	callback = function()
		vim.lsp.buf.format({ name = 'bash-language-server' })
	end,
})
