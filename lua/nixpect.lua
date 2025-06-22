M = {}

M.test = function()
	local w = vim.fn.expand('<cWORD>')
	local a = vim.system({ 'nix', 'eval', 'self#nixosConfigurations.dell.config.' .. w }):wait()
	vim.notify(a.signal .. a.code .. a.stderr .. a.stdout)
end

return M
