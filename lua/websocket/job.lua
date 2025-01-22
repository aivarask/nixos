local Job = require('plenary.job')
-- async
local data = {}
Job:new({
	command = 'lua',
	args = { '/etc/nixos/lua/ws.lua' },
	on_stdout = function(_, line)
		--
		vim.notify(line)
		table.insert(data, line)
	end,
	on_exit = function()
		print('done')
	end,
}):start()

-- Job:new({})
