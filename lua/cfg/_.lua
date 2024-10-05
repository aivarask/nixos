require("which-key").setup({ preset = "helix", sort = { "alphanum" } })
require("nvim-surround").setup({})
require("auto-session").setup({
	auto_session_allowed_dirs = { "/etc/nixos" },
	log_level = vim.log.levels.ERROR,
})
require("colorizer").setup({})
if vim.uv.os_getenv("DISPLAY") then
	require("image").setup({ backend = "ueberzug" })
end
require("nvim-web-devicons").setup({
	override = {
		["nix"] = { icon = "", color = "#ffffff", cterm_color = "110", name = "Nix" },
	},
})

require("fidget").setup({})
require("notify").setup({ render = "compact" })
vim.notify = require("notify")
