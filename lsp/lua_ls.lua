local library = {
	vim.env.VIMRUNTIME,
	-- '/etc/static/luajit/share/lua/5.1',
	-- '${3rd}/luv/library',
	-- '${3rd}/busted/library',
	-- '${3rd}/luassert/library',
	-- '/etc/nixos/httpd'
}

local userThirdParty = {
	-- '/etc/static/lua-language-server/share/lua-language-server/meta/3rd',
}

local path = {
	'lua/?/init.lua',
	'lua/?.lua',
	--
	'?/init.lua',
	'?.lua',
}

local pathStrict = true

for i = #library, 1, -1 do
	local value = library[i]
	if string.find(value, 'myNeovimPackages') then
		table.remove(library, i)
	end
end
for _, name in ipairs({
	'nvim%-tree',
	'nvim%-web%-devicons'
	, 'telescope.nvim',
	-- 'plenary.nvim',
}) do
	for _, v in ipairs(vim.api.nvim_list_runtime_paths()) do
		if string.find(v, name) then
			table.insert(library, v)
		end
	end
end

return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			completion = {
				autoRequire = true,
				callSnippet = 'Disable',
				displayContext = 7,
				enable = true,
				keywordSnippet = 'Both',
				postfix = '@',

			},
			diagnostics = { -- luals.github.io/wiki/diagnostics
				disable = { 'lowercase-global', 'unudirsed-local', 'unused-vararg', 'unused-function', 'need-check-nil', 'empty-block', 'missing-fields' },
				globals = { "mp", "client", "root", "screen" },
				ignoredFiles = "Disable"
			},
			format = {
				enable = true
			},
			hint = {
				enable = true,
				arrayIndex = 'Auto',
				setType = true,
			},
			runtime = {
				version = 'LuaJIT',
				pathStrict = pathStrict,
				path = path,
			},
			workspace = {
				checkThirdParty = false, -- https://luals.github.io/wiki/settings/#workspacecheckthirdparty
				library = library,
				-- library = vim.api.nvim_list_runtime_paths(),
				preloadFileSize = 600,
				ignoreDir = { 'node_modules', 'vendor', 'mpv/scripts' },
				-- https://luals.github.io/wiki/settings/#workspaceuserthirdparty
				userThirdParty = userThirdParty,
			},
		},
	}
}
