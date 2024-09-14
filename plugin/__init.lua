vim.loader.enable()
vim.notify = require "notify"

vim.cmd [[
" let &runtimepath.=',/root/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]]

require "luals"

local wk = require "which-key"
wk.add {
	{
		"<M-s>",
		function()
			local c = vim.fn.getcmdline()
			local n = c:gsub('lua', 'help')
			vim.notify(n)
			vim.fn.setcmdline(n, 1)
		end,
		mode = { 'c', },
	},

}
wk.add {
	{ "<leader>n", group = "nix", },
	{ "<leader>nn", function()
		vim.ui.select({ 'nixos-rebuild switch --verbose --fast', 'nix flake metadata', 'clock', }, {}, function(item, idx)
			if item ~= nil then
				local Job = require "plenary.job"
				local t = vim.split(item, ' ')
				local head = table.remove(t, 1)
				Job:new {
					command = head,
					args = t,
					on_stdout = function(_, line)
						-- print(line)
					end,
					on_exit = function(self, code, signal)
						require 'pl.pretty' (self:result())
					end,
				}:start()
			end
		end)
	end, },
}
