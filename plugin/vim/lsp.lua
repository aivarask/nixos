vim.lsp.inspect_client = function()
	local function get_keys(t)
		local keys = {}
		for key, _ in pairs(t) do
			table.insert(keys, key)
		end
		return keys
	end
	local pretty = require "pl.pretty"
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients { bufnr = bufnr, }

	vim.ui.select(clients, {
		prompt = "Select LSP client",
		format_item = function(client) return client.name end,
	}, function(selected_client)
		if selected_client then
			local client = vim.lsp.get_client_by_id(selected_client.id)
			local keys = get_keys(client)

			vim.ui.select(keys, {}, function(key)
				if key and client ~= nil and client[key] then
					pretty(client[key])
				else
					pretty(client)
				end
			end)
		end
	end)
end

