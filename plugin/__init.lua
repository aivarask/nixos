vim.loader.enable()
vim.cmd [[
" let &runtimepath.=',/root/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]]

require "notify".setup { render = "minimal", }
vim.notify = require 'notify'




require "luals"
require "zzz"
