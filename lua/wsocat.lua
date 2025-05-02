local stdin = uv.new_pipe()
local stdout = uv.new_pipe()
local stderr = uv.new_pipe()

local handle, pid = uv.spawn('websocat', {
	args = { '-s', '4000' },
	stdio = { stdin, stdout, stderr }
}, print)

print("process opened", handle, pid)

---@diagnostic disable-next-line: param-type-mismatch
uv.read_start(stdout, function(err, data)
	assert(not err, err)
	if data then
		print("stdout chunk", stdout, data)
	else
		print("stdout end", stdout)
	end
end)

---@diagnostic disable-next-line: param-type-mismatch
uv.read_start(stderr, function(err, data)
	assert(not err, err)
	if data then
		print("stderr chunk", stderr, data)
	else
		print("stderr end", stderr)
	end
end)

-- ---@diagnostic disable-next-line: param-type-mismatch
-- uv.write(stdin, 'Hello')
