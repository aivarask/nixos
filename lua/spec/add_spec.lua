describe("Add function", function()
	it("should add two numbers correctly", function()
		assert.are.equal(5, 5)
	end)
end)

describe('match', function()
	local url = "http://www.example-all.com/woo-foo.html#abc;"
	local pattern = "http[s]?://[%w%-%/%.%#]+"
	print('match: ', string.match(url, pattern))
end)
