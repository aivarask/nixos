vim.loader.enable()
vim.notify = require "notify"

vim.cmd [[
let &runtimepath.=',/root/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]]


require "luals"
