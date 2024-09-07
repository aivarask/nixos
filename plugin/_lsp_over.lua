require "lsp-file-operations".setup {}
require "refactoring".setup {}
require "lsp_signature".setup {
	floating_window = false,
	close_timeout = 1000,
	hint_prefix = "🚀 ",
	toggle_key = "<M-k>",
}
-- require "hover".setup {
-- 	init = function() require "hover.providers.lsp" end,
-- }

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('LspAttachConfig', {}),
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
		end
	end,
})
