-- http://www.lua.org/manual/5.1/manual.html#pdf-string.match
print('Hi')
describe('Matches', function()
  it('match', function()
    assert(('a'):match('a'), 'a a match fails')
    assert.Nil(('a'):match('b'), 'a b matches')
    assert.True(true, 'this is wrong')
  end)
end)

function foo()
  local path = vim.fn.expand('%')
  print('path', path)
  print('foo')
end

describe('foo', function()
  print(vim.fn.expand('%'))
  it('ok', function()
    foo()
  end)
end)
