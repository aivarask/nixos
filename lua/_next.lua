require "iron.core".setup {
	config = {
		repl_definition = {
			-- lua = require "iron.fts.lua",
			sh = { command = { "zsh", }, },
		},
		repl_open_cmd = require "iron.view".right "40%",
	},
	keymaps = {
		-- send_line = "<M-s>",
	},
}
