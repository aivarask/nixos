local c = require 'lspconfig'
c.lua_ls.setup {
	settings = { -- https://luals.github.io/wiki/settings/
		Lua = {
			runtime = { version = "LuaJIT", pathStrict = true, path = { "lua/?/init.lua", "lua/?.lua", "?/init.lua", "?.lua", }, },
			workspace = { checkThirdParty = false, library = {
				vim.env.VIMRUNTIME,
				"${3rd}/luv/library",
				vim.env.LUA_LIB,
			}, },
		},
	},
}

greet = function()
	vim.notify 'hello 3'
end

print(vim.env.LUA_LIB)
assert(1 == 1, 'this is not equal')

-- if vim.lsp.luals.client or nil then
-- 	vim.lsp.luals:runtime(true, {
-- 		"nvim%-lspconfig",
-- 		"none%-ls.nvim",
-- 	}):notify()
-- end

-- if vim.lsp.luals.client or nil then
-- 	vim.lsp.luals:runtime(true, {
-- 		"notify",
-- 		"fidget",
-- 		-- "hover",
-- 		"plenary.nvim",
-- 	}):notify()
-- end
-- vim.lsp.luals = {
-- 	client = vim.lsp.get_clients { name = 'lua_ls', }[1] or nil,
-- 	inspect = function(self)
-- 		vim.print(self.client.config.settings.Lua.workspace.library)
-- 	end,
-- 	runtime = function(self, enable, list)
-- 		if enable then
-- 			local library = self.client.config.settings.Lua.workspace.library
-- 			for i = #library, 1, -1 do
-- 				local value = library[i]
-- 				if string.find(value, "myNeovimPackages") then table.remove(library, i) end
-- 			end
-- 			for _, name in ipairs(list) do
-- 				for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
-- 					if string.find(path, name) then table.insert(library, path) end
-- 				end
-- 			end
-- 			vim.notify 'lua_ls.runtime'
-- 		end
-- 		return self
-- 	end,
-- 	notify = function(self)
-- 		self.client.notify("workspace/didChangeConfiguration", { settings = self.client.config.settings, })
-- 		vim.notify 'lua_ls.notif workspace/didChangeConfiguration'
-- 	end,
-- }
