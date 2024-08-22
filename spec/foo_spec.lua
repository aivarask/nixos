it("it 3", function()
	assert.True(true)
	for dir in io.popen("./", "r"):lines() do
		print(dir)
	end
end)
