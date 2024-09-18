vim.fn.sign_define("DapBreakpoint", { text = "🟢", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟡", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🔴", texthl = "", linehl = "", numhl = "" })

local dap = require("dap")
-- dap.set_log_level "DEBUG"
dap.defaults.fallback.terminal_win_cmd = "60vsplit new"
-- dap.defaults.fallback.switchbuf = "useopen"
-- require "persistent-breakpoints".setup { load_breakpoints_event = { "BufReadPost", }, }
require("nvim-dap-virtual-text").setup({})
local dapui = require("dapui")
local widgets = require("dap.ui.widgets")

local wk = require("which-key")
wk.add({ --- @see d_dap
	{ "<leader>d", group = "DAP" },
	{ "<leader>da", dap.attach, desc = "attach" },
	{ "<leader>dB", dap.step_back, desc = "step_back" },
	{ "<leader>db", group = "breakpoint" },
	{ "<leader>dbc", dap.clear_breakpoints, desc = "clear_breakpoints" },
	{ "<leader>dbl", dap.list_breakpoints, desc = "list_breakpoints" },
	{ "<leader>dbs", dap.set_breakpoint, desc = "set_breakpoint" },
	{ "<leader>dbt", dap.toggle_breakpoint, desc = "toggle_breakpoint" },
	{ "<leader>dbx", dap.set_exception_breakpoints, desc = "set_exception_breakpoints" },
	{ "<leader>dc", dap.continue, desc = "continue" },
	{ "<leader>dC", dap.reverse_continue, desc = "reverse_continue" },
	{ "<leader>dd", dap.disconnect, desc = "disconnect" },
	{ "<leader>df", group = "frame" },
	{ "<leader>dff", dap.focus_frame, desc = "focus_frame" },
	{ "<leader>dfr", dap.restart_frame, desc = "restart_frame" },
	{ "<leader>dL", dap.launch, desc = "launch" },
	{ "<leader>dl", dap.run_last, desc = "run_last" },
	{ "<leader>dp", dap.pause, desc = "pause" },
	{ "<leader>dR", dap.restart, desc = "restart" },
	{ "<leader>dr", dap.run, desc = "run" },
	{ "<leader>dS", dap.status, desc = "status" },
	{ "<leader>ds", group = "step" },
	{ "<leader>dsh", dap.step_out, desc = "out" },
	{ "<leader>dsj", dap.step_over, desc = "over" },
	{ "<leader>dsk", dap.step_back, desc = "back" },
	{ "<leader>dsl", dap.step_into, desc = "into" },
	{ "<leader>dT", dap.repl.toggle, desc = "repl.toggle" },
	{
		"<leader>dt",
		function()
			dapui.toggle({ reset = true })
		end,
		desc = "dapui.toggle",
	},
	{ "<leader>dU", dap.down, desc = "down" },
	{ "<leader>du", dap.up, desc = "up" },
	{ "<leader>dw", widgets.hover, desc = "widgets.hover" },
	{ "<leader>dW", widgets.preview, desc = "widgets.preview" },
	{ "<leader>dx", dap.run_to_cursor, desc = "run_to_cursor" },
	{
		"<leader>dX",
		function()
			widgets.centered_float(widgets.scopes)
		end,
		desc = "widgets.scopes",
	},
	{ "<leader>dz", dap.close, desc = "close" },
	{ "<leader>dZ", dap.terminate, desc = "terminate" },
})
