local reload = require("plenary.reload")

vim.cmd([[
source /etc/nixos/vim/vimrc.vim
]])

function ReloadModule(arg)
	local target = vim.fn.expand(arg)
	require("plenary.reload").reload_module(target)
	print("reload ", target)
end

function ReloadFile()
	local module_name = vim.fn.expand("%:t:r")
	if module_name == "init" then
		module_name = vim.fn.expand("%:h:t")
	end
	require("plenary.reload").reload_module(module_name)
	print("plenary.reload.reload_module:", module_name)
end

function ReloadArg(arg)
	reload.reload_module(arg)
end

-- https://github.com/rmagatti/auto-session/
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup({
	log_level = "info",
	auto_session_enable_last_session = false,
	auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
	auto_session_enabled = true,
	auto_save_enabled = nil,
	auto_restore_enabled = nil,
	auto_session_suppress_dirs = nil,
	auto_session_use_git_branch = nil,
	-- the configs below are lua only
	bypass_session_save_file_types = nil,
	-- log_level = "info", auto_save_enabled = true, auto_restore_enabled = true
})
require("treesitter")
require("nvim_tree")
require("completion")
require("autopairs")
require("lua_line")
require("project")
require("misc")

require("lsp.sumneko")
require("lsp.vimls")
-- require("lsp.tsserver")
require("lsp.typescript")
require("lsp.svelte")
require("lsp.tailwind")
require("lsp.prismals")
require("lsp.null-ls")
require("lsp.emmet-ls")
require("lsp.json")
require("lsp.rnix")
require("lsp.bashls")
-- require("lsp.sqlls")
require("lsp.sqls")

require("lsp.cssls")
-- require("lsp.stylelint")

-- -- require("lsp.clangd")
-- -- require("lsp.python")
-- -- require("lsp.php")
-- require("debug.init")

-- PERF: fully optimized
-- HACK: hmm, this looks a bit funny
-- FIX: this needs fixing

require("colorizer").setup({}) -- https://github.com/norcalli/nvim-colorizer.lua
require("telescope").setup({}) -- https://github.com/nvim-telescope/telescope.nvim
require("todo-comments").setup({
	keywords = {
		-- TYPE:
		TYPE = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		-- TYPE = { icon = " ", color = "info" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--glob=!node_modules",
			"--glob=!build",
		},
		pattern = [[\b(KEYWORDS):]],
	},
}) -- https://github.com/folke/todo-comments.nvim
require("trouble").setup({
	height = 20,
}) -- https://github.com/folke/trouble.nvim
require("diaglist").init({}) -- https://github.com/onsails/diaglist.nvim
