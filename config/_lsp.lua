local c = require("lspconfig")

local nixd = require("lspconfig.server_configurations.nixd").default_config
local lua_ls = require("lspconfig.server_configurations.lua_ls").default_config

-- lsp-quickstart
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	callback = function(ev)
		vim.lsp.start({
			name = "nixd",
			cmd = { "nixd" },
			root_dir = vim.fs.root(ev.buf, { "flake.lock" }),
			settings = {
				nixd = {
					formatting = { command = { "nixfmt" } },
					nixpkgs = { expr = "import <nixpkgs> { }" },
					-- nixpkgs = { expr = '(builtins.getFlake "/etc/nixos").inputs.nixpkgs' },
					options = {
						-- nixos = { expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.dell.options' },
						nixos = {
							expr = '(builtins.getFlake ("git+file://" + toString /etc/nixos)).nixosConfigurations.dell.options',
						},
						-- home_manager = { expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.root.options' },
						home_manager = {
							expr = '(builtins.getFlake ("git+file://" + toString /etc/nixos)).homeConfigurations.root.options',
						},
					},
				},
			},
		})
		if true then
			vim.lsp.start({
				name = "nil",
				cmd = { "nil" },
				settings = {
					["nil"] = {
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
