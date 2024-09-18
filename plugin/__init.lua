vim.loader.enable()
vim.cmd [[
let &runtimepath.=',/etc/nixos/pack/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]]

require "notifications"
require 'dapl.setup'
-- require 'dapl.ui'
-- require 'dapl.lua'
require "ls.lua"
require "completion"
require "completion_p"
