-- vim:fdl=4
local library = {
	vim.env.VIMRUNTIME,
	'${3rd}/luv/library',
}

for i = #library, 1, -1 do
	local value = library[i]
	if string.find(value, 'myNeovimPackages') then
		table.remove(library, i)
	end
end
for _, name in ipairs({
	'nvim%-cmp',
	'outline.nvim',
	'nvim%-tree',
	'none%-ls.nvim',
	'nvim%-lspconfig',
	'toggleterm.nvim',
	'which%-key.nvim',
	'lsp%-file%-operations',
	'nvim%-dap',
	'nvim%-dap%-ui',
	'lualine.nvim',
	'telescope.nvim',
}) do
	for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
		if string.find(path, name) then
			table.insert(library, path)
		end
	end
end

local client = vim.lsp.get_clients({ name = 'luals' })[1] or nil
if client ~= nil then
	vim.print(client.settings.Lua.workspace.library)
	client.settings.Lua.workspace.library = library
	client.notify('workspace/didChangeConfiguration', { settings = client.settings })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
-- capabilities.workspace.fileOperations.didRename

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'lua',
	callback = function()
		if false then
			vim.lsp.start({
				name = 'ls.lua',
				cmd = { 'ls.lua' },
				-- 	cmd = { 'lua', '/etc/nixos/lua/ls.lua' },
				-- 	cmd_env = { LUA_PATH = '/etc/nixos/lua/?.lua' },
				-- 	settings = {
				-- 		a = 1,
				-- 	},
			})
		end
		vim.lsp.start({
			name = 'luals',
			capabilities = capabilities,
			cmd = { 'lua-language-server' },
			root_dir = vim.fs.root(0, { 'flake.lock' }),
			settings = {
				Lua = { --- @type LuaSettings
					completion = {
						autoRequire = true,
						callSnippet = 'Disable',
						displayContext = 7,
						enable = true,
						keywordSnippet = 'Both',
						postfix = '@',
					},
					diagnostics = {
						disable = { 'lowercase-global' },
					},
					hint = {
						enable = true,
						arrayIndex = 'Auto',
						setType = true,
					},
					runtime = {
						version = 'LuaJIT',
						pathStrict = true,
						path = { 'lua/?/init.lua', 'lua/?.lua', '?/init.lua', '?.lua' },
					},
					workspace = {
						checkThirdParty = false,
						library = library,
						preloadFileSize = 600,
						ignoreDir = { 'node_modules', 'vendor' },
					},
				},
			},
		})
	end,
})
require('null-ls').register({ require('null-ls.builtins.formatting.stylua') })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.lua' },
	desc = 'format null-ls',
	callback = function() vim.lsp.buf.format({ name = 'null-ls' }) end,
})
