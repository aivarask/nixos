if (vim.system({ 'fuser', '4000/tcp' }):wait().code ~= 1) then
	assert(vim.system({ 'fuser', '4000/tcp', '-k' }):wait().code == 0)
end

vim.api.nvim_create_autocmd('BufWritePost', {
	group = vim.api.nvim_create_augroup('websocket:save', { clear = true }),
	pattern = {
		'*.{php,html,css,txt}'
	},
	callback = function()
		os.execute([[echo 'save' | websocat ws://127.0.0.1:4000]])
	end
})

require 'wsocat'

return {}
