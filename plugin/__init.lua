vim.loader.enable()
vim.cmd [[
" let &runtimepath.=',/root/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]]


-- require "fidget".setup {}
n = vim.notify
-- vim.notify = require 'notify'

require "notifications"
require "luals"
