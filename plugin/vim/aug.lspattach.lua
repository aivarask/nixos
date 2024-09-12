local lspattach = vim.api.nvim_create_augroup('LspAttachGroup', {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = lspattach,
	desc = "user config",
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
			if client.name == 'lua_ls' then
				vim.lsp.luals.client = client
				vim.lsp.luals:lualib(true)
			end
		end
	end,
})
