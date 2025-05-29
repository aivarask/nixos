---@diagnostic disable: param-type-mismatch
local stdin = uv.new_pipe()
local stdout = uv.new_pipe()
local stderr = uv.new_pipe()

local verbose = false
if not verbose then
	print = function(...)
		return 0
	end
end

local handle, pid = uv.spawn('websocat', {
	args = { '-s', '4000' },
	stdio = { stdin, stdout, stderr }
}, print)

print("process opened", handle, pid)

uv.read_start(stdout, function(err, data)
	assert(not err, err)
	if data then
		if data == 'save' then
			uv.write(stdin, 'save\n')
		else
			print("stdout chunk", stdout, data)
			uv.write(stdin, data)
		end
	else
		print("stdout end", stdout)
	end
end)

uv.read_start(stderr, function(err, data)
	assert(not err, err)
	if data then
		print("stderr chunk", stderr, data)
		-- 	uv.shutdown(stdin, function()
		-- 		print("stdin shutdown", stdin)
		-- 		uv.close(handle, function()
		-- 			print("process closed", handle, pid)
		-- 		end)
		-- 	end)
	else
		print("stderr end", stderr)
	end
end)
