-- http://www.lua.org/manual/5.1/manual.html#pdf-string.match
describe('Matches', function()
  it('match', function()
    assert(('a'):match('a'), 'a a match fails')
    assert.Nil(('a'):match('b'), 'a b matches')
  end)
end)
