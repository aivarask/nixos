-- vim:foldlevel=3 nofoldenable
require('genghis').setup({
	backdrop = {
		enabled = true,
		blend = 50,
	},
	-- default is `"trash"` on Mac/Windows, and `{ "gio", "trash" }` on Linux
	trashCmd = 'trash', -- gio trash
})
-- require('lsp-file-operations').setup({})
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
	{ '<space>',   group = 'LSP' },
	{ '<space>1',  require('goto-preview').goto_preview_definition,      desc = 'definition' },
	{ '<space>2',  require('goto-preview').goto_preview_type_definition, desc = 'type_definition' },
	{ '<space>3',  require('goto-preview').goto_preview_implementation,  desc = 'implementation' },
	{ '<space>4',  require('goto-preview').goto_preview_declaration,     desc = 'declaration' },
	{ '<space>5',  require('goto-preview').close_all_win,                desc = 'close_all_win' },
	{ '<space>6',  require('goto-preview').goto_preview_references,      desc = 'references' },
	{ '<space>a',  vim.lsp.buf.code_action,                              desc = 'code_action',    mode = { 'n', 'v' } },
	{ '<space>D',  vim.lsp.buf.declaration,                              desc = 'declaration' },
	{ '<space>dd', vim.lsp.buf.definition,                               desc = 'definition' },
	{ '<space>e',  vim.diagnostic.open_float,                            desc = 'open_float' },
	{ '<space>i',  vim.lsp.buf.implementation,                           desc = 'implementation' },
	{ '<space>O',  [[<cmd>LspOverloadsSignature<CR>]] },
	{ '<space>o',  [[<cmd>Outline<CR>]] },
	{ '<space>p',  group = 'goto-preview' },
	{ '<space>pd', require('goto-preview').goto_preview_definition,      desc = 'definition' },
	{ '<space>pt', require('goto-preview').goto_preview_type_definition, desc = 'type_definition' },
	{ '<space>pi', require('goto-preview').goto_preview_implementation,  desc = 'implementation' },
	{ '<space>pD', require('goto-preview').goto_preview_declaration,     desc = 'declaration' },
	{ '<space>pc', require('goto-preview').close_all_win,                desc = 'close_all_win' },
	{ '<space>pr', require('goto-preview').goto_preview_references,      desc = 'references' },
	{ '<space>q',  vim.diagnostic.setloclist,                            desc = 'setloclist' },
	{ '<space>r',  vim.lsp.buf.references,                               desc = 'references' },
	{ '<space>R',  vim.lsp.buf.rename,                                   desc = 'rename' },
	{ '<space>s',  vim.lsp.buf.signature_help,                           desc = 'signature_help' },
	{ '<c-b>',     vim.lsp.buf.signature_help,                           desc = 'signature_help', mode = { 'i' } },
	{ '<space>t',  vim.lsp.buf.type_definition,                          desc = 'type_definition' },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if false then
	vim.lsp.log.set_level(vim.lsp.log_levels.INFO)
	vim.lsp.log.set_format_func(vim.inspect)
end
vim.api.nvim_create_autocmd('Filetype', {
	pattern = { 'javascript', 'typescript' },
	callback = function()
		vim.lsp.start({
			name = 'tsserver',
			-- https://github.com/microsoft/TypeScript
			-- https://github.com/typescript-language-server/typescript-language-server
			-- cmd = { '/etc/nixos/node_modules/.bin/typescript-language-server', '--stdio' },
			cmd = { 'typescript-language-server', '--stdio' },
			root_dir = vim.fs.root(0, { 'package.json' }),
			init_options = { hostInfo = 'neovim' },
			capabilities = capabilities,
		})
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


require('null-ls').register({ require('null-ls.builtins.formatting.black') })
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python' },
	desc = 'lsp pyright',
	callback = function()
		vim.lsp.start({
			cmd = {
				'pyright-langserver',
				'--stdio',
			},
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = 'openFilesOnly',
						stubPath = '/run/current-system/sw/lib/python3.12/site-packages',
					},
				},
			},
		})
	end,
})



require('null-ls').register({
	require('null-ls.builtins.formatting.sqlfluff').with({ extra_args = { '--dialect', 'sqlite' } }),
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
