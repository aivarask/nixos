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
}) do
	for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
		if string.find(path, name) then
			table.insert(library, path)
		end
	end
end

local LSP = vim.api.nvim_create_augroup('LSP', {})
vim.api.nvim_create_autocmd('FileType', {
	group = LSP,
	pattern = 'lua',
	callback = function(ev)
		vim.lsp.start({
			name = 'lua_ls',
			cmd = { 'lua-language-server' },
			root_dir = vim.fs.root(ev.buf, { 'flake.lock' }),
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
					diagnostics = {},
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
					},
				},
			},
		})
	end,
})

local client = vim.lsp.get_clients({ name = 'lua_ls' })[1] or nil
if client ~= nil then
	vim.print(client.settings.Lua.workspace.library)
	client.settings.Lua.workspace.library = library
	client.notify('workspace/didChangeConfiguration', { settings = client.settings })
end

-- lsp-quickstart
vim.api.nvim_create_autocmd('FileType', {
	group = LSP,
	pattern = 'nix',
	callback = function(ev)
		-- local nixd = require('lspconfig.server_configurations.nixd').default_config
		vim.lsp.start({
			name = 'nixd',
			cmd = { 'nixd' },
			root_dir = vim.fs.root(ev.buf, { 'flake.lock' }),
			settings = {
				nixd = {
					formatting = { command = { 'nixfmt' } },
					nixpkgs = { expr = 'import <nixpkgs> { }' },
					options = {
						nixos = {
							expr = '(builtins.getFlake ("git+file://" + toString /etc/nixos)).nixosConfigurations.dell.options',
						},
						home_manager = {
							expr = '(builtins.getFlake ("git+file://" + toString /etc/nixos)).homeConfigurations.root.options',
						},
					},
				},
			},
		})
		if false then
			vim.lsp.start({
				name = 'nil',
				cmd = { 'nil' },
				settings = {
					['nil'] = {
						formatting = { command = nil },
						nix = {
							maxMemoryMB = 20480,
							flake = {
								-- autoArchive = true,
								-- autoEvalInputs = true,
								-- nixpkgsInputName = "nixpkgs",
							},
						},
					},
				},

				on_attach = function(client)
					client.server_capabilities.completionProvider = nil
				end,
			})
		end
	end,
})
