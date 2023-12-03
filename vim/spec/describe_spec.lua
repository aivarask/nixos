describe('Describe', function()
  local bello = function(boo) return 'bello ' .. boo end

  local bounter

  before_each(function() bounter = 0 end)

  it('It function', function()
    bounter = 100
    assert.equals('bello Brian', bello('Brian'))
  end)

  it('contains before_each', function() assert.equals(0, bounter) end)
end)
