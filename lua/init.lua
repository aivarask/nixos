vim.cmd [[
"source $XDG_CONFIG_HOME/nvim/nvimrc.vim
let &runtimepath.=',/etc/nixos'
runtime! lua/_config/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}
]]
vim.loader.enable()
uv = vim.uv
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)
vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition)

if (vim.system({ 'fuser', '4000/tcp' }):wait().code ~= 1) then
	assert(vim.system({ 'fuser', '4000/tcp', '-k' }):wait().code == 0)
end

-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	pattern = { 'index.*' },
-- 	callback = function()
-- 		os.execute([[echo 'save' | websocat ws://127.0.0.1:4000]])
-- 	end
-- })

require 'wsocat'
-- require 'wserv'
