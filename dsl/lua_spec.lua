--- Incerement function
function incr(a)
  return a + 1
end

if describe ~= nil and vim == nil then
  print('Hello, Lua')
  describe('Dsl describe', function()
    it('increment', function()
      assert.True(true)
      assert(incr(1) == 2, 'Incremented unsuccessfully')
    end)
  end)
end
