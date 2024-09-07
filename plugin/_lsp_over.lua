require "lsp-file-operations".setup {}
require "refactoring".setup {}
require "lsp_signature".setup {
	floating_window = false,
	close_timeout = 1000,
	hint_prefix = "🚀 ",
	toggle_key = "<M-k>",
}

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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	desc = "own attach config",
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client ~= nil then
			if client.supports_method "textDocument/completion" then vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" end
			if client.supports_method "textDocument/definition" then vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc" end
			if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, }) end

			if client.server_capabilities.signatureHelpProvider then
				require "lsp-overloads".setup(client, {
					keymaps = {
						next_signature = "j",
						previous_signature = "k",
						next_parameter = "l",
						previous_parameter = "h",
						close_signature = "<M-s>",
					},
					display_automatically = false,
				})
			end
		end
	end,
})

