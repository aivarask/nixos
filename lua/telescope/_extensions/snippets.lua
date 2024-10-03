return require("telescope").register_extension({
	exports = {
		snippets = function()
			local ff = require("telescope.builtin").find_files
			return ff({ cwd = "/etc/nixos/snippets" })
		end,
	},
})
