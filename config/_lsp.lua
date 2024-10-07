local c = require("lspconfig")

local nixd = require("lspconfig.server_configurations.nixd").default_config

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
					-- nixpkgs = { expr = "import <nixpkgs> { }" },
					nixpkgs = { expr = '(builtins.getFlake "/etc/nixos").inputs.nixpkgs' },
					options = {
						nixos = { expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.dell.options' },
						-- 	home_manager = {
						-- 		expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.root.options',
						-- 	},
					},
				},
			},
		})
	end,
})

-- c.nixd.setup({
-- 	settings = {

-- 		nixd = {
-- 			nixpkgs = { expr = "import <nixpkgs> { }" },
-- 			formatting = { command = { "nixfmt" } },
-- 			-- nixpkgs = {
-- 			-- 	expr = '(builtins.getFlake "/etc/nixos").inputs.nixpkgs',
-- 			-- },
-- 			options = {
-- 				-- nixos = {
-- 				-- 	expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.dell.options',
-- 				-- },
-- 				-- 	home_manager = {
-- 				-- 		expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.root.options',
-- 				-- 	},
-- 			},
-- 		},
-- 	},
-- })

-- c.nil_ls.setup({
-- 	autostart = true,
-- 	settings = {
-- 		["nil"] = {
-- 			formatting = { command = nil },
-- 			nix = {
-- 				maxMemoryMB = 20480,
-- 				flake = {
-- 					-- autoArchive = true,
-- 					-- autoEvalInputs = true,
-- 					-- nixpkgsInputName = "nixpkgs",
-- 				},
-- 			},
-- 		},
-- 	},
-- })
