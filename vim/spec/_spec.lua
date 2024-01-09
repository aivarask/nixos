local too = require "too"
describe('runtime', function()
  it('require custom paths', function()
    too.custom()
  end)
  it('require system wide', function()
    too.system()
  end)
end)
