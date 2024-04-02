-- --- Incerement function
function incr(a)
  print('incr function')
  return a + 1
end

-- if describe ~= nil and vim == nil then
--   print('Hello, Lua')
describe('increment describe', function()
  it('increment', function()
    incr(1)
    assert.True(true)
    assert(incr(1) == 2, 'Incremented unsuccessfully')
  end)
end)
-- end

describe("some basics", function()
  local bello = function(boo)
    return "bello " .. boo
  end

  local bounter

  before_each(function()
    bounter = 0
  end)

  it("some test", function()
    bounter = 100
    assert.equals("bello Brian", bello("Brian"))
  end)

  it("some other test", function()
    assert.equals(0, bounter)
  end)
end)
