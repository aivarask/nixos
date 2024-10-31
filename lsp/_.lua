require('null-ls').setup()
require('lsp-file-operations').setup({})
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
	{ '<space>t', vim.lsp.buf.type_definition, desc = 'type_definition' },
})

require('lspconfig.configs.clangd')
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
	callback = function()
		vim.lsp.start({
			cmd = { 'clangd' },
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.c' },
	desc = 'format clang',
	callback = function()
		vim.lsp.buf.format({ name = 'clang' })
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
			cmd = { 'taplo', 'lsp', 'stdio' },
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.toml' },
	desc = 'format taplo not working',
	callback = function()
		-- vim.lsp.buf.format({ name = 'taplo' })
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
