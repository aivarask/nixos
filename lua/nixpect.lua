local nixpect = {}

nixpect.test = function()
	local w = vim.fn.expand('<cWORD>')
	local a = vim.system({ 'nix', 'eval', 'self#nixosConfigurations.dell.config.' .. w }):wait()
	-- boot.blacklistedKernelModules
	-- foo

	vim.notify(a.signal .. a.code .. a.stderr .. a.stdout, vim.log.levels.ERROR)
end


return nixpect
