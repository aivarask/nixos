vim.loader.enable()
vim.cmd [[
" let &runtimepath.=',/root/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]]

local notify = vim.notify

-- require "fidget".setup {}
-- vim.notify = require 'notify'

require "notifications"
require "luals"
