describe("Add function", function()
	it("should add two numbers correctly", function()
		assert.are.equal(5, 5)
	end)
end)

describe('match', function()
	local url = "http://www.example-all.com/woo-foo.html#abc;"
	local pattern = "http[s]?://[%w%-%/%.%#]+"
	local result = string.match(url, pattern)
	print('match: ', result)
	assert.are.equal(result, url)
end)
