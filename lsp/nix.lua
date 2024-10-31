-- lsp-quickstart
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'nix',
	callback = function(ev)
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
