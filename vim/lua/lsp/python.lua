local util = require("lspconfig.util")
require("lspconfig").pysetup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),

	cmd = { "pylsp" },
	filetypes = { "python" },
	root_dir = function(fname)
		local root_files = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
		}
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
	end,
	single_file_support = true,
})

-- require("lspconfig").pyright.setup({
-- 	cmd = { "pyright-langserver", "--stdio" },
-- 	filetypes = { "python" },
-- 	root_dir = function(startpath)
-- 		return M.search_ancestors(startpath, matcher)
-- 	end,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				autoSearchPaths = true,
-- 				diagnosticMode = "workspace",
-- 				useLibraryCodeForTypes = true,
-- 			},
-- 		},
-- 	},
-- 	single_file_support = true,
-- })
