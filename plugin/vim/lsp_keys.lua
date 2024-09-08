wk.add {
	{ "<space>",  group = "LSP", },
	{ "<space>a", vim.lsp.buf.code_action,    desc = "code_action",    mode = { "n", "v", }, },
	{ "<space>D", vim.lsp.buf.declaration,    desc = "declaration", },
	{ "<space>d", vim.lsp.buf.definition,     desc = "definition", },
	{ "<space>e", vim.diagnostic.open_float,  desc = "open_float", },
	{ "<space>I", vim.lsp.inspect_client,     desc = "inspect_client", noremap = true, },
	{ "<space>i", vim.lsp.buf.implementation, desc = "implementation", },
	{ "<space>l", function()
		local client = vim.lsp.get_clients { name = "lua_ls", }[1]
		local library = client.config.settings.Lua.workspace.library or nil
		vim.print(library)
	end, desc = "lua_ls library", },
	{ "<space>O", [[<cmd>LspOverloadsSignature<CR>]], },
	{ "<space>o", [[<cmd>Outline<CR>]], },
	{ "<space>q", vim.diagnostic.setloclist,                desc = "setloclist", },
	{ "<space>R", vim.lsp.buf.references,                   desc = "references", },
	{ "<space>r", vim.lsp.buf.rename,                       desc = "rename", },
	{ "<space>S", require "lsp_signature".toggle_float_win, desc = "toggle_float_win", },
	{ "<space>s", vim.lsp.buf.signature_help,               desc = "signature_help", },
	{ "<space>t", vim.lsp.buf.type_definition,              desc = "type_definition", },
}

require "goto-preview".setup {}
wk.add {
	{ "<leader>p",  group = "goto-preview", },
	{ "<leader>pd", require "goto-preview".goto_preview_definition,      desc = "definition", },
	{ "<leader>pt", require "goto-preview".goto_preview_type_definition, desc = "type_definition", },
	{ "<leader>pi", require "goto-preview".goto_preview_implementation,  desc = "implementation", },
	{ "<leader>pD", require "goto-preview".goto_preview_declaration,     desc = "declaration", },
	{ "<leader>pc", require "goto-preview".close_all_win,                desc = "close_all_win", },
	{ "<leader>pr", require "goto-preview".goto_preview_references,      desc = "references", },
}
