require("lsp-file-operations").setup({})
require("lsp_signature").setup({
	hint_prefix = "🚀 ",
	floating_window = false,
	close_timeout = 1000,
	-- toggle_key = nil,
})
require("hover").setup({
	init = function()
		require("hover.providers.lsp")
	end,
})
require("outline").setup({
	symbols = {
		icons = {
			Class = { icon = "󰠱", hl = "Type" },
			String = { icon = "󰉿", hl = "String" },
			Struct = { icon = "󰙅", hl = "Structure" },
			Event = { icon = "", hl = "Type" },
			TypeParameter = { icon = "T", hl = "Identifier" },
		},
	},
})

local wk = require("which-key")
wk.add({
	{ "<space>", group = "LSP" },
	{ "<space>a", vim.lsp.buf.code_action, desc = "code_action", mode = { "n", "v" } },
	{ "<space>D", vim.lsp.buf.declaration, desc = "declaration" },
	{ "<space>d", vim.lsp.buf.definition, desc = "definition" },
	{ "<space>e", vim.diagnostic.open_float, desc = "open_float" },
	{ "<space>I", vim.lsp.inspect_client, desc = "inspect_client", noremap = true },
	{ "<space>i", vim.lsp.buf.implementation, desc = "implementation" },
	{ "<space>O", [[<cmd>LspOverloadsSignature<CR>]] },
	{ "<space>o", [[<cmd>Outline<CR>]] },
	{ "<space>q", vim.diagnostic.setloclist, desc = "setloclist" },
	{ "<space>R", vim.lsp.buf.references, desc = "references" },
	{ "<space>r", vim.lsp.buf.rename, desc = "rename" },
	{ "<space>S", require("lsp_signature").toggle_float_win, desc = "toggle_float_win" },
	{ "<space>s", vim.lsp.buf.signature_help, desc = "signature_help" },
	{ "<space>t", vim.lsp.buf.type_definition, desc = "type_definition" },
})

require("goto-preview").setup({})
wk.add({
	{ "<leader>p", group = "goto-preview" },
	{ "<leader>pd", require("goto-preview").goto_preview_definition, desc = "definition" },
	{ "<leader>pt", require("goto-preview").goto_preview_type_definition, desc = "type_definition" },
	{ "<leader>pi", require("goto-preview").goto_preview_implementation, desc = "implementation" },
	{ "<leader>pD", require("goto-preview").goto_preview_declaration, desc = "declaration" },
	{ "<leader>pc", require("goto-preview").close_all_win, desc = "close_all_win" },
	{ "<leader>pr", require("goto-preview").goto_preview_references, desc = "references" },
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
		prompt = "Select LSP client",
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
