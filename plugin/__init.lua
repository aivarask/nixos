vim.loader.enable()
vim.cmd [[
let &runtimepath.=',/root/one-small-step-for-vimkind'
runtime! lsp/**/*{.lua,.vim}
runtime! ~box/**/*{.lua,.vim}
]]
