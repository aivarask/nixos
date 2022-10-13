local reload = require("plenary.reload")

vim.cmd([[
source /etc/nixos/vim/vimrc.vim
]])

function ReloadModule(arg)
	local target = vim.fn.expand(arg)
	require("plenary.reload").reload_module(target)
	print("reload ", target)
end

function ReloadFile(arg)
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

require("treesitter")
require("nvim_tree")
require("completion")
require("autopairs")
require("lua_line")
require("project")
require("misc")

require("lsp.sumneko")
require("lsp.vimls")
require("lsp.null-ls")
require("lsp.tsserver")
require("lsp.svelte")
require("lsp.tailwind")
require("lsp.prismals")
require("lsp.emmet-ls")
require("lsp.json")
require("lsp.rnix")
require("lsp.bashls")

require("lsp.cssls")
-- require("lsp.stylelint")

-- -- require("lsp.clangd")
-- -- require("lsp.python")
-- -- require("lsp.php")
-- require("debug.init")
