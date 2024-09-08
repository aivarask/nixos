if vim.lsp.luals.client or nil then
	vim.lsp.luals:runtime {
		"notify",
		"fidget",
		-- "hover",
	}:notify()
end
require "fidget".setup {}

require "lsp-file-operations".setup {}
require "refactoring".setup {}
require "lsp_signature".setup {
	floating_window = false,
	close_timeout = 1000,
	hint_prefix = "🚀 ",
	toggle_key = "<M-k>",
}
require "hover".setup {
	init = function() require "hover.providers.lsp" end,
}
require "outline".setup {
	symbols = {
		icons = {
			File = { icon = '󰈔', hl = 'Identifier', },
			Module = { icon = '󰆧', hl = 'Include', },
			Namespace = { icon = '󰅪', hl = 'Include', },
			Package = { icon = '󰏗', hl = 'Include', },
			Class = { icon = '󰠱', hl = 'Type', },
			Method = { icon = 'ƒ', hl = 'Function', },
			Property = { icon = '', hl = 'Identifier', },
			Field = { icon = '󰆨', hl = 'Identifier', },
			Constructor = { icon = '', hl = 'Special', },
			Enum = { icon = 'ℰ', hl = 'Type', },
			Interface = { icon = '󰜰', hl = 'Type', },
			Function = { icon = '', hl = 'Function', },
			Variable = { icon = '', hl = 'Constant', },
			Constant = { icon = '', hl = 'Constant', },
			String = { icon = '󰉿', hl = 'String', },
			Number = { icon = '#', hl = 'Number', },
			Boolean = { icon = '⊨', hl = 'Boolean', },
			Array = { icon = '󰅪', hl = 'Constant', },
			Object = { icon = '⦿', hl = 'Type', },
			Key = { icon = '🔐', hl = 'Type', },
			Null = { icon = 'NULL', hl = 'Type', },
			EnumMember = { icon = '', hl = 'Identifier', },
			Struct = { icon = '󰙅', hl = 'Structure', },
			Event = { icon = '', hl = 'Type', },
			Operator = { icon = '+', hl = 'Identifier', },
			TypeParameter = { icon = 'T', hl = 'Identifier', },
			Component = { icon = '󰅴', hl = 'Function', },
			Fragment = { icon = '󰅴', hl = 'Constant', },
			TypeAlias = { icon = ' ', hl = 'Type', },
			Parameter = { icon = ' ', hl = 'Identifier', },
			StaticMethod = { icon = ' ', hl = 'Function', },
			Macro = { icon = ' ', hl = 'Function', },
		},

	},
}
