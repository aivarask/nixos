vim.cmd [[
"source $XDG_CONFIG_HOME/nvim/nvimrc.vim
let &runtimepath.=',/etc/nixos'
let &runtimepath.=',/etc/nixos/httpd'
let &runtimepath.=',/etc/nixos/strudel.nvim'
runtime! lua/_config/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}
]]
vim.loader.enable()
uv = vim.uv
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)
vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition, {
	-- desc = 'vim.lsp.buf.definition'
})
vim.cmd [[
"runtime! */_*{.lua,.vim}
]]
require 'gettransfer'
require 'nixpect'
vim.keymap.set({ 'n' }, '<leader>\'', require 'nixpect'.test)
require 'cf_diagnostic'
require 'cf_completion'
require 'cf_lsp'
require 'cf_neotest'
require 'cf_nvim-tree'
require 'cf_telescope'
require 'cf_toggleterm'
-- require 'strudel'
require("strudel").setup({
	-- Strudel web user interface related options
	ui = {
		-- Maximise the menu panel
		-- (optional, default: true)
		maximise_menu_panel = true,
		-- Hide the Strudel menu panel (and handle)
		-- (optional, default: false)
		hide_menu_panel = false,
		-- Hide the default Strudel top bar (controls)
		-- (optional, default: false)
		hide_top_bar = false,
		-- Hide the Strudel code editor
		-- (optional, default: false)
		hide_code_editor = false,
		-- Hide the Strudel eval error display under the editor
		-- (optional, default: false)
		hide_error_display = false,
	},
	-- Automatically start playback when launching Strudel
	-- (optional, default: true)
	start_on_launch = true,
	-- Set to `true` to automatically trigger the code evaluation after saving the buffer content
	-- Only works if the playback was already started (doesn't start the playback on save)
	-- (optional, default: false)
	update_on_save = false,
	-- Enable two-way cursor position sync between Neovim and Strudel editor
	-- (optional, default: true)
	sync_cursor = true,
	-- Report evaluation errors from Strudel as Neovim notifications
	-- (optional, default: true)
	report_eval_errors = true,
	-- Path to a custom CSS file to style the Strudel web editor (base64-encoded and injected at launch)
	-- This allows you to override or extend the default Strudel UI appearance
	-- (optional, default: nil)
	-- custom_css_file = "/path/to/your/custom.css",
	-- Headless mode: set to `true` to run the browser without launching a window
	-- (optional, default: false)
	headless = true,
	-- Path to the directory where Strudel browser user data (cookies, sessions, etc.) is stored
	-- (optional, default: `~/.cache/strudel-nvim/`)
	browser_data_dir = "~/.cache/strudel-nvim/",
	-- Path to a (chromium-based) browser executable of choice
	-- (optional, default: nil)
	browser_exec_path = "chromium",
})

-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	group = vim.api.nvim_create_augroup('sway', { clear = true }),
-- 	pattern = {
-- 		'*/waybar/*.*',
-- 		'sway/*',
-- 	},
-- 	callback = function()
-- 		if vim.bo.filetype == 'swayconfig' then
-- 			os.execute('swaymsg reload')
-- 		elseif vim.bo.filetype == 'jsonc' then
-- 			os.execute('pkill -USR2 waybar')
-- 		end
-- 	end
-- })

-- vnew | put =luaeval('vim.inspect(vim)')
-- vim.api.nvim_create_user_command('Lua', View, { nargs = '+', complete = 'command' })
function View(v)
	-- Use a unique filename to avoid opening an existing buffer.
	vim.cmd.vnew("lua output " .. os.time())
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "delete"
	vim.bo.swapfile = false
	vim.cmd.setfiletype("lua")
	local start_line = 0
	local bufnr = vim.fn.bufnr()
	for i = 1, select('#') do
		local val = select(i)
		local lines = vim.split(vim.inspect(val), "\n")
		if i == 1 then
			lines[1] = "output = " .. lines[1] -- make buffer closer to valid lua
		else
			lines[1] = ", " .. lines[1]
		end
		vim.api.nvim_buf_set_lines(bufnr, start_line, -1, false, lines)
		start_line = -1
	end
end
