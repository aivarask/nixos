require('null-ls').setup({
	sources = {},
})

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
