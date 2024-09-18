ins = function(self)
	print(vim.inspect(self))
	return self
end

string.ins = ins
local foo = 'foo'
foo:ins()


-- https://gist.github.com/oatmealine/655c9e64599d0f0dd47687c1186de99f
local tab1 = { foo = 'bar', }
local tab2 = setmetatable({}, { __index = tab1, })

print(tab2.foo) --> 'bar'

-- __tostring
local myTable = { a = { b = 1, }, }
local myMetatable = {}
setmetatable(myTable, myMetatable)
myMetatable.__tostring = function(table)
	local foo = "The table was converted to a string"
	print(foo)
	return vim.inspect(table)
end

print(myTable) -- Output: The table was converted to a string
