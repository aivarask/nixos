it("reload", function()
	local pid_result = vim.system({ "pidof", "sxhkd" }):wait()
	local pid = pid_result.stdout:gsub("\n", "")
	local res = vim.system({ "kill", "-SIGUSR1", pid }):wait()
	assert.equals(0, pid_result.code)
	assert.equals("2532\n", pid_result.stdout)
	assert.equals("2532", pid)
	assert.equals(0, res.code)
end)

-- describe('foo', function()
--   local tempfile
--   before_each(function()
--     -- Create temporary file
--     tempfile = vim.fn.tempname()
--   end)
--   it('Always succeeds', function()
--     assert.is_true(vim.endswith('abc', 'c'))
--   end)
-- end)
-- local pid = [["123
--               "]]
-- print(pid:gsub('[", ]', ''))
-- vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
--   pattern = 'sxhkdrc',
--   callback = function()
--     local on_exit = function(obj)
--       print 'sxhkd reload'
--       print(obj.code)
--       print(obj.signal)
--       print(obj.stdout)
--       print(obj.stderr)
--     end
--     local pid = vim.system({ 'pidof', 'sxhkd', }, { text = false, }, function(o)
--       if (o.signal) then
--         -- vim.system({ 'kill', '-SIGUSR1', o.stdout, }, { text = false, }, on_exit)
--         vim.system({ 'kill', '-SIGUSR1', o.stdout:gsub('\\n', ''), }, { text = false, }, on_exit)
--       end
--     end)
--   end,
-- })
