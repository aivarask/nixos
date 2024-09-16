local library = {
	vim.env.VIMRUNTIME,
	"${3rd}/luv/library",
	vim.env.LUA_LIB,
}

for i = #library, 1, -1 do
	local value = library[i]
	if string.find(value, "myNeovimPackages") then table.remove(library, i) end
end
for _, name in ipairs {
	'which%-key',
	"nvim%-nio",
	'plenary.nvim',
	'notify',
	'fidget',
	"nvim%-web%-devicons",
	-- "none%-ls.nvim",
	-- "nvim%-lspconfig",
	"nvim%-cmp",
	"nvim%-autopairs"
} do
	for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
		if string.find(path, name) then table.insert(library, path) end
	end
end

local c = require 'lspconfig'
c.lua_ls.setup {
	settings = { -- https://luals.github.io/wiki/settings/
		Lua = {
			runtime = { version = "LuaJIT", pathStrict = true, path = { "lua/?/init.lua", "lua/?.lua", "?/init.lua", "?.lua", }, },
			workspace = { checkThirdParty = false,
				library = library,
			},
		},
	},
}

require "nvim-web-devicons".setup {
	override = {
		["nix"] = { icon = "", color = "#85ea2d", cterm_color = "110", name = "Nix", },
	},
}

local client = vim.lsp.get_clients { name = 'lua_ls', }[1] or nil
if client ~= nil then
	vim.notify('lua_ls_' .. client.id)
	-- client.notify("workspace/didChangeConfiguration", { settings = client.config.settings, })
else
	vim.notify('client not available, startup case', vim.log.levels.WARN)
end
