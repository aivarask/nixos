-- https://github.com/nvim-lua/plenary.nvim/blob/master/TESTS_README.md#testing-guide
-- https://github.com/lunarmodules/luassert
describe('Busted', function()
  it('asserts', function()
    assert(1, 1)
    assert.True(true)
    assert(true == true, 'Should be equal')
    assert.True(true)
  end)
end)
