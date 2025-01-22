-- vim.api.nvim_command('command! -nargs=1 Watch call luaeval(\'watch_file(_A)\', expand(\'<args>\'))
-- vim.api.nvim_command('checktime')
local w = vim.uv.new_fs_event()

function on_change(err, fname, status)
	print(err, fname)
	require('pl.pretty')(status)
	w:stop()
	watch_file(fname)
end

function watch_file(fname)
	local path = vim.api.nvim_call_function('fnamemodify', { fname, ':p' })
	w:start(
		path,
		{},
		vim.schedule_wrap(function(...)
			on_change(...)
		end)
	)
end
-- watch_file('./lua/_wa.lua')

local d = vim.uv.new_fs_event()
local path = '/etc/nixos/aiva'
d:start(path, {
	-- recursive = true,
	--	watch_entry = true
}, function(err, filename, events)
	print(filename, events.change, events.rename)
end)

d:start(path, flags, function(err, filename, events) end)

local res = package.loaded['_wa']
