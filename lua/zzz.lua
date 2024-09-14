local wk = require "which-key"
wk.add {
	{ "<leader>n", group = "nix", },
	{ "<leader>nn", function()
		vim.ui.select({
			'clock',
			'nixos-rebuild switch --verbose --fast',
			'nix flake metadata',
		}, {}, function(item, idx)
			if item ~= nil then
				local Job = require "plenary.job"
				local t = vim.split(item, ' ')
				local head = table.remove(t, 1)
				Job:new {
					command = head,
					args = t,
					on_stdout = function(_, line)
						vim.notify(line)
					end,
					on_exit = function(self, code, signal)
						require 'pl.pretty' (self:result())
					end,
				}:start()
			end
		end)
	end, },
}


