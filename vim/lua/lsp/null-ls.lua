local null_ls = require("null-ls")
local b = null_ls.builtins
local sources = {

	b.formatting.stylua,
	b.formatting.fixjson,
	b.code_actions.gitsigns,
	b.diagnostics.statix,
	b.code_actions.statix,
	b.diagnostics.phpstan,
	b.code_actions.eslint_d,
	b.diagnostics.eslint_d,
	null_ls.builtins.diagnostics.eslint_d.with({
		prefer_local = "node_modules/.bin",
	}),

	b.formatting.prettierd.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
			-- "json",
			"yaml",
			"markdown",
			"mdx",
			-- "graphql",
			-- Append
			"markdown.mdx",
			"pug",
		},
	}),

	b.formatting.shfmt.with({
		filetypes = { "sh", "zsh" },
		command = "shfmt",
		args = { "-filename", "$FILENAME" },
		extra_args = { "-i", "2", "-ci" },
	}),

	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
	-- require("null-ls.helpers").conditional(function(utils)
	-- 	return utils.root_has_file(".eslintrc.js") and b.formatting.eslint_d or b.formatting.prettierd
	-- end),
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#diagnostics
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#hover
}
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
local defaults = {
	cmd = { "nvim" },
	debounce = 250,
	debug = false,
	default_timeout = 5000,
	diagnostic_config = nil,
	diagnostics_format = "#{m}",
	fallback_severity = vim.diagnostic.severity.ERROR,
	log_level = "warn",
	notify_format = "[null-ls] %s",
	on_attach = nil,
	on_init = nil,
	on_exit = nil,
	root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
	sources = nil,
	update_in_insert = false,
}

null_ls.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	sources = sources,
})
