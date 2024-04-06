describe("desc 1", function()
  it('it 11', function()
    assert.True(false)
  end)
end)

describe("desc 2", function()
  local bello = function(boo)
    return "bello " .. boo
  end

  local bounter

  before_each(function()
    bounter = 0
  end)

  it("it 1", function()
    bounter = 100
    assert.equals("bello Brian", bello("Brian"))
  end)

  it("it 2", function()
    assert.equals(0, bounter)
  end)
end)


it('it 3', function()
  assert.True(false)
end)
