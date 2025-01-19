-- local handle = io.popen('websocketd --port=8080 ws')
-- local result = handle:read('*a')
-- handle:close()

local nio = require('nio')

-- nio.run(function()
-- 	local path = nio.fn.tempname()
-- 	print(path)
-- 	vim.fn.setreg('+', path)

-- 	local file = nio.file.open(path, 'w+')

-- 	local process = nio.process.run({
-- 		cmd = 'websocketd',
-- 		args = { '--port=8080', '--loglevel=trace', '/etc/nixos/_g/ws' },
-- 		stdout = file,
-- 	})

-- 	process.result(0)

-- 	local output = file.read(nil, 0)
-- 	print(output)

-- 	process.close() -- Closes the file
-- 	-- 	local output = task.stdout.read()
-- 	-- 	print(output)
-- end)
-- local a = require('plenary.async')

-- local Job = require('plenary.job')
-- Job:new({
-- 	command = 'websocketd',
-- 	args = { '--port=8080', '/etc/nixos/_g/ws' },
-- 	cwd = '/etc/nixos/_g',
-- 	env = { ['a'] = 'b' },
-- 	on_stdout = function(err, data) print(data) end,
-- 	on_exit = function(j, return_val)
-- 		print(return_val)
-- 		print(j:result())
-- 	end,
-- }):start()
