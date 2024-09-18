require("neotest").setup({
	summary = { open = "botright vsplit | vertical resize 30 | set winfixwidth" },
	output_panel = { open = "botright vsplit | vertical resize 60 | set winfixwidth" },
	adapters = {
		-- require('neotest-busted'), -- local
		--- @see https://github.com/nvim-neotest/neotest-plenary
		--- @see _spec.lua no dap
		require("neotest-plenary"),

		--- @see https://github.com/nvim-neotest/neotest-go/
		--- .go _test.go
		--- func Test*|Example*
		-- require("neotest-go")({ recursive_run = true }),

		--- ~= node_modules
		--- .test.js
		-- require('neotest-node'),

		--- @see https://github.com/nvim-neotest/neotest-python/
		--- ~= venv
		--- test_*.py *_test.py
		--- enabled when entered
		--- dap preconfigured
		-- require("neotest-python")({}), -- dap pytest builtin (usefull example)

		--- @see https://github.com/olimorris/neotest-phpunit
		--- ~= node_modules vendor
		--- *Test.php
		-- require('neotest-phpunit')({
		--   filter_dirs = { ".git", "node_modules", "vendor" },
		--   -- root_files = { "jar.json" },
		--   --   env = { XDEBUG_CONFIG = "idekey=neotest" },
		--   dap =
		--   {
		--     type = "php",
		--     request = "launch",
		--     name = "php",
		--     port = 9003,
		--     stopOnEntry = false,
		--     xdebugSettings = {
		--       max_children = 512,
		--       max_data = 1024,
		--       max_depth = 4,
		--     },
		--     breakpoints = {
		--       exception = {
		--         Notice = false,
		--         Warning = false,
		--         Error = false,
		--         Exception = false,
		--         ["*"] = false,
		--       },
		--     },
		--   },
		-- }),

		--- @see https://github.com/rouge8/neotest-rust/?tab=readme-ov-file
		--- not working
		-- require('neotest-rust'),

		-- require("neotest-playwright").adapter({
		--   options = {
		--     persist_project_selection = true,
		--     enable_dynamic_test_discovery = true,
		--   },
		-- }),
	},
})
