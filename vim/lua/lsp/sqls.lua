require("lspconfig").sqls.setup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqls
	-- https://github.com/lighttiger2505/sqls
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	settings = {
		sqls = {
			connections = {
				{
					driver = "mysql",
					dataSourceName = "root:l@tcp(127.0.0.1:3306)/mysql",
				},
				-- {
				-- 	driver = "postgresql",
				-- 	dataSourceName = "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
				-- },
			},
		},
	},
})
