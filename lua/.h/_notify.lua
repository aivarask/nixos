local notify_clock = function()
	local nio = require('nio')
	local notify = require('notify')
	local first = notify.notify(os.date(), vim.log.levels.INFO, { title = 'Date' })
	local prev = first.id
	local task = nio.run(function()
		for i = 1, 3, 1 do
			local current = notify.notify(os.date(), vim.log.levels.INFO, { replace = prev or 0 })
			nio.sleep(1000)
			prev = current.id
		end
		notify.notify('Date notification end', vim.log.levels.WARN, { replace = prev })
	end)
end

local a = function()
	vim.ui.select({
		'clock',
		'nixos-rebuild switch --verbose --fast',
		'nix flake metadata',
	}, {}, function(item, idx)
		if item ~= nil then
			local Job = require('plenary.job')
			local t = vim.split(item, ' ')
			local head = table.remove(t, 1)
			Job:new({
				command = head,
				args = t,
				on_stdout = function(_, line)
					vim.notify(line)
				end,
				on_exit = function(self, code, signal)
					vim.inspect(self:result())
				end,
			}):start()
		end
	end)
end
