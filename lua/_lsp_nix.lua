-- lsp-quickstart
vim.api.nvim_create_autocmd('FileType', {
	-- group = LSP,
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

require('null-ls').register({ require('null-ls.builtins.formatting.nixfmt') })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.nix' },
	desc = 'null-ls',
	callback = function()
		vim.lsp.buf.format({ name = 'null-ls' })
	end,
})
