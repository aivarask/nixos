require "nvim-autopairs".setup { --- @see nvim-autopairs
	disable_filetype = { "TelescopePrompt", "vim", },
	check_ts = true,
	fast_wrap = {
		map = "<M-w>",
	},
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp" --- @see nvim-cmp
cmp.event:clear()
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
npairs = require 'nvim-autopairs'

print(vim.inspect(npairs))
