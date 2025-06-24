vim.cmd [[
"source $XDG_CONFIG_HOME/nvim/nvimrc.vim
let &runtimepath.=',/etc/nixos'
let &runtimepath.=',/etc/nixos/httpd'
runtime! lua/_config/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}
]]
vim.loader.enable()
uv = vim.uv
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)
vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition, {
	-- desc = 'vim.lsp.buf.definition'
})
vim.cmd [[
"runtime! */_*{.lua,.vim}
]]
require 'gettransfer'
require 'nixpect'
vim.keymap.set({ 'n' }, '<leader>\'', require 'nixpect'.test)
require 'cf_diagnostic'
require 'cf_lsp'
require 'cf_neotest'
require 'cf_nvim-tree'
require 'cf_telescope'
require 'cf_toggleterm'

-- vnew | put =luaeval('vim.inspect(vim)')
-- vim.api.nvim_create_user_command('Lua', View, { nargs = '+', complete = 'command' })
function View(v)
	-- Use a unique filename to avoid opening an existing buffer.
	vim.cmd.vnew("lua output " .. os.time())
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "delete"
	vim.bo.swapfile = false
	vim.cmd.setfiletype("lua")
	local start_line = 0
	local bufnr = vim.fn.bufnr()
	for i = 1, select('#') do
		local val = select(i)
		local lines = vim.split(vim.inspect(val), "\n")
		if i == 1 then
			lines[1] = "output = " .. lines[1] -- make buffer closer to valid lua
		else
			lines[1] = ", " .. lines[1]
		end
		vim.api.nvim_buf_set_lines(bufnr, start_line, -1, false, lines)
		start_line = -1
	end
end
