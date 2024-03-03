--- Incerement function
function incr(a)
  return a + 1
end

print('Hello, Lua')

if describe ~= nil then
  describe('Dsl describe', function()
    it('increment', function()
      assert.True(true)
      assert(incr(1) == 2, 'Incremented unsuccessfully')
    end)
  end)
end
