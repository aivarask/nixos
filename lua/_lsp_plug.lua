require('lsp-file-operations').setup({})

require('outline').setup({
	outline_window = {
		position = 'left',
		width = 15,
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
		auto_preview = true,
	},
})

require('goto-preview').setup({})
require('which-key').add({
	{ '<space>', group = 'LSP' },
	{ '<space>a', vim.lsp.buf.code_action, desc = 'code_action', mode = { 'n', 'v' } },
	{ '<space>D', vim.lsp.buf.declaration, desc = 'declaration' },
	{ '<space>dd', vim.lsp.buf.definition, desc = 'definition' },
	{ '<space>e', vim.diagnostic.open_float, desc = 'open_float' },
	{ '<space>I', vim.lsp.inspect_client, desc = 'inspect_client', noremap = true },
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
	{ '<space>R', vim.lsp.buf.references, desc = 'references' },
	{ '<space>r', vim.lsp.buf.rename, desc = 'rename' },
	{ '<space>s', vim.lsp.buf.signature_help, desc = 'signature_help' },
	{ '<space>t', vim.lsp.buf.type_definition, desc = 'type_definition' },
})

vim.lsp.inspect_client = function()
	local function get_keys(t)
		local keys = {}
		for key, _ in pairs(t) do
			table.insert(keys, key)
		end
		return keys
	end
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	vim.ui.select(clients, {
		prompt = 'Select LSP client',
		format_item = function(client)
			return client.name
		end,
	}, function(selected_client)
		if selected_client then
			local client = vim.lsp.get_client_by_id(selected_client.id)
			local keys = get_keys(client)

			vim.ui.select(keys, {}, function(key)
				if key and client ~= nil and client[key] then
					vim.print(client[key])
				else
					vim.print(client)
				end
			end)
		end
	end)
end
