local npairs = require("nvim-autopairs")
local cmp = require("cmp")
npairs.setup({
	-- https://github.com/windwp/nvim-autopairs
	disable_filetype = { "TelescopePrompt" },
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]",
	fast_wrap = {}, -- https://github.com/windwp/nvim-autopairs#fastwrap
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		-- javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})

local ts_conds = require("nvim-autopairs.ts-conds")
local Rule = require("nvim-autopairs.rule")
-- press % => %% only while inside a comment or string
npairs.add_rules({
	Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
	Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
