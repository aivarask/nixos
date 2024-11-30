-- https://esvi.ai/posts/how-i-debug-php-with-neovim/
vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })
require('persistent-breakpoints').setup({
	save_dir = vim.fn.stdpath('data') .. '/breakpoints',
	load_breakpoints_event = 'BufReadPost',
})

dapui = require('dapui')
--- @see dap-adapter
--- @see dap-configuration
dap = require('dap')
local widgets = require('dap.ui.widgets')
dap.defaults.fallback.focus_terminal = true
require('nvim-dap-virtual-text').setup({})
require('persistent-breakpoints').setup({ load_breakpoints_event = { 'BufReadPost' } })

local osv = require('osv')
dap.adapters = {
	nlua = function(callback, config)
		callback({ type = 'server', host = '127.0.0.1', port = 8086 })
	end,
	run_this = function(callback, config, parent)
		require('osv').run_this()
	end,
}
dap.configurations.lua = {
	{ name = 'run_this', request = 'launch', type = 'run_this' },
}

dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
	-- {
	-- 	name = 'launch $file',
	-- 	type = 'php',
	-- 	request = 'launch',
	-- 	port = 9003,
	-- 	cwd = '${fileDirname}',
	-- 	program = '${file}',
	-- 	runtimeExecutable = 'php',
	-- },
	{
		name = 'launch',
		type = 'php',
		request = 'launch',
		port = 9003,
	},
}

-- -- toggle the UI elements after certain events
-- dap.listeners.after.event_initialized['dapui_config'] = function()
-- 	dapui.open()
-- end

-- dap.listeners.before.event_terminated['dapui_config'] = function()
-- 	dapui.close()
-- end

-- dap.listeners.before.event_exited['dapui_config'] = function()
-- 	dapui.close()
-- end

dapui.setup({
	controls = {
		element = 'repl',
		enabled = true,
		icons = {
			disconnect = '',
			pause = '',
			play = '',
			run_last = '',
			step_back = '',
			step_into = '',
			step_out = '',
			step_over = '',
			terminate = '',
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = 'single',
		mappings = {
			close = { 'q', '<Esc>' },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = '',
		current_frame = '',
		expanded = '',
	},
	layouts = {
		{
			elements = {
				{
					id = 'scopes',
					size = 0.25,
				},
				{
					id = 'breakpoints',
					size = 0.25,
				},
				{
					id = 'stacks',
					size = 0.25,
				},
				{
					id = 'watches',
					size = 0.25,
				},
			},
			position = 'left',
			size = 40,
		},
		{
			elements = {
				{
					id = 'repl',
					size = 0.5,
				},
				{
					id = 'console',
					size = 0.5,
				},
			},
			position = 'bottom',
			size = 20,
		},
	},
	mappings = {
		edit = 'e',
		expand = { '<CR>', '<2-LeftMouse>' },
		open = 'o',
		remove = 'd',
		repl = 'r',
		toggle = 't',
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})

require('which-key').add({
	--- @see dap-mappings
	{ '<F5>', dap.continue, desc = 'dap.continue' },
	{ '<F6>', [[:PBToggleBreakpoint<cr>]] },
	{ '<F7>', ':lua dap.list_breakpoints(true)<cr>' },
	{ '<F8>', [[:PBClearAllBreakpoints<cr>]] },
	{ '<F9>', ':lua dapui.toggle()<CR>' },
	{ '<leader>td', group = 'dap' },
	{ '<leader>tdc', [[:Telescope dap commands<cr>]] },
	{ '<leader>tdC', [[:Telescope dap configurations<cr>]] },
	{ '<leader>tdf', [[:Telescope dap frames<cr>]] },
	{ '<leader>tdl', [[:Telescope dap list_breakpoints<cr>]] },
	{ '<leader>tdv', [[:Telescope dap variables<cr>]] },
})
