vim_shared = require('vim.shared') -- https://github.com/neovim/neovim
vim.lsp = require('vim.lsp')
vim.lsp.get_client_by_id(1)

busted = require('busted') -- https://github.com/lunarmodules/busted
inspect = require('inspect') -- https://github.com/kikito/inspect.lua#examples-of-use
assert(inspect(1) == '1')
assert(inspect({ 1, 2, 3, 4 }) == '{ 1, 2, 3, 4 }')
pretty = require('pl.pretty') -- https://github.com/lunarmodules/Penlight#module-overview
function pp(any)
  print(pretty(any))
end

plenary = require('plenary') -- https://github.com/nvim-lua/plenary.nvim
p = require('plenary.path')
luassert = require('luassert')
_debug = require('std._debug')(false) -- https://lua-stdlib.github.io/_debug/
version = require('std._debug.version')
--
