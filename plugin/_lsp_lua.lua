local add_lualib = function(library)
	local lualib = vim.split(os.getenv "LUA_LIB" or "", ";")
	for k, v in pairs(lualib) do
		local found = false
		for j, lib_v in pairs(library) do
			if v == lib_v then found = true end
		end
		if not found then table.insert(library, v) end
	end
end

local add_runtimes = function(library)
	for i = #library, 1, -1 do
		local value = library[i]
		if string.find(value, "myNeovimPackages") then table.remove(library, i) end
	end

	local from_runtime = {
		"nvim%-cmp",
		"nvim%-autopairs",
		"which%-key.nvim",
		"nvim%-lspconfig",
		"none%-ls.nvim",
		"fidget", "notify",

	}
	for _, name in ipairs(from_runtime) do
		for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
			if string.find(path, name) then table.insert(library, path) end
		end
	end
end

--- @param client vim.lsp.Client
local update = function(client)
	local library = client.config.settings.Lua.workspace.library
	add_lualib(library)
	add_runtimes(library)
	client.notify("workspace/didChangeConfiguration", { settings = client.config.settings, })
end

if vim.tbl_isempty(vim.lsp.get_clients { name = "lua_ls", }) then
	local library = { vim.env.VIMRUNTIME, "${3rd}/luv/library", }
	add_lualib(library)
	add_runtimes(library)
	require "lspconfig".lua_ls.setup {
		settings = { -- https://luals.github.io/wiki/settings/
			Lua = {
				runtime = { version = "LuaJIT", pathStrict = true, path = { "lua/?/init.lua", "lua/?.lua", "?/init.lua", "?.lua", }, },
				workspace = { checkThirdParty = false, library = library, },
			},
		},
	}
else
	update(vim.lsp.get_clients { name = "lua_ls", }[1])
end

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("lua_ls configuration ", {}),
	pattern = { ".luarc.json", "plugin/_lsp_lua.lua", },
	desc = "workspace/didChangeConfiguration",
	callback = function()
		local client = vim.lsp.get_clients { name = "lua_ls", }[1] or nil
		if client ~= nil then
			local library = client.config.settings.Lua.workspace.library
			add_runtimes(library)
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings, })
			vim.notify 'lua_ls workspace/didChangeConfiguration'
		end
	end,
})
