-- NOTE: https://neovim.io/doc/user/lua-guide.html
vim.loader.enable()
vim.cmd [[
let &runtimepath.=',/root/one-small-step-for-vimkind'
runtime! lsp/**/*{.lua,.vim}
]]
