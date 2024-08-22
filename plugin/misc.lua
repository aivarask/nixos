vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup { auto_session_allowed_dirs = { "/etc/nixos" } }
require("telescope").load_extension "session-lens"
require("outline").setup {}
require("dressing").setup {}
require("colorizer").setup {}
require("nvim-web-devicons").setup {} --- @see devicons
require("smart-semicolon").setup {}
if vim.uv.os_getenv "DISPLAY" then require("image").setup { backend = "ueberzug" } end
require("nvim-tree").setup {
	view = { width = 25, signcolumn = "no" },
	git = { enable = false },
	sync_root_with_cwd = true,
	update_focused_file = { enable = true, update_root = true },
	ui = { confirm = { trash = false } },
	on_attach = function(bufnr)
		local api = require "nvim-tree.api"
		api.config.mappings.default_on_attach(bufnr)
	end,
}

-- https://github.com/ii14/neorepl.nvim
-- https://github.com/Vigemus/iron.nvim
require("iron.core").setup {
	config = {
		repl_definition = {
			lua = require "iron.fts.lua",
			sh = { command = { "zsh" } },
		},
		repl_open_cmd = require("iron.view").right "40%",
	},
}
