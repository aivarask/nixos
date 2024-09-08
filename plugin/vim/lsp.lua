vim.lsp.inspect_client = function()
	local function get_keys(t)
		local keys = {}
		for key, _ in pairs(t) do
			table.insert(keys, key)
		end
		return keys
	end
	local pretty = require "pl.pretty"
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients { bufnr = bufnr, }

	vim.ui.select(clients, {
		prompt = "Select LSP client",
		format_item = function(client) return client.name end,
	}, function(selected_client)
		if selected_client then
			local client = vim.lsp.get_client_by_id(selected_client.id)
			local keys = get_keys(client)

			vim.ui.select(keys, {}, function(key)
				if key and client ~= nil and client[key] then
					pretty(client[key])
				else
					pretty(client)
				end
			end)
		end
	end)
end


vim.lsp.luals = {
	client = vim.lsp.get_clients { name = 'lua_ls', }[1] or nil,
	inspect = function(self)
		vim.print(self.client.config.settings.Lua.workspace.library)
	end,
	lualib = function(self)
		local library = self.client.config.settings.Lua.workspace.library
		local lualib = vim.split(os.getenv "LUA_LIB" or "", ";")
		for k, v in pairs(lualib) do
			local found = false
			for j, lib_v in pairs(library) do
				if v == lib_v then found = true end
			end
			if not found then table.insert(library, v) end
		end
		vim.notify "lualib ok"
		return self
	end,
	runtime = function(self, list)
		local library = self.client.config.settings.Lua.workspace.library
		for i = #library, 1, -1 do
			local value = library[i]
			if string.find(value, "myNeovimPackages") then table.remove(library, i) end
		end
		for _, name in ipairs(list) do
			for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
				if string.find(path, name) then table.insert(library, path) end
			end
		end
		vim.notify 'runtime ok'
		return self
	end,
	notify = function(self)
		self.client.notify("workspace/didChangeConfiguration", { settings = self.client.config.settings, })
		vim.notify 'lua_ls notify'
	end,
}


vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("lua_ls configuration ", {}),
	pattern = { ".luarc.json", "plugin/vim/lsp.lua", },
	desc = "client.notify workspace/didChangeConfiguration",
	callback = function()
		vim.lsp.luals:notify()
	end,
})
