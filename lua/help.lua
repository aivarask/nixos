local ui_select = {
	test = function()
		vim.fn.jobstart('echo hello', {
			cwd = vim.uv.cwd(),
			-- on_exit = some_function,
			-- on_stderr = some_third_function,
			on_stdout = function(jobid, data, event)
				-- vim.notify(data)
				vim.api.nvim_open_win(vim.cmd('!echo hello'), true, {
					relative = 'cursor',
					width = 64,
					height = 12,
					row = 1,
					col = 1,
					style = 'minimal',
					border = 'solid',
				})
			end,
		})
	end,

	help = function()
		local mode = vim.fn.mode()
		vim.ui.select({
			vim.fn.expand('<cword>'),
			vim.fn.expand('<cWORD>'),
			vim.fn.expand('<cfile>'),
			vim.fn.expand('<cexpr>'),
		}, {}, function(first)
			if first then
				local opts = {
					'help',
					'Man',
					'nixos-option -F self -r',
				}
				vim.ui.select(opts, {}, function(second)
					if second == 'help' then
						vim.cmd.help(first)
					elseif second == 'Man' then
						vim.cmd.Man(first)
					elseif second == opts[3] then
						vim.cmd('!' .. second .. ' ' .. first)
					else
					end
				end)
			end
		end)
	end,
}

require('which-key').add({
	{ '<F1>', ui_select.help, mode = { 'n', 'i', 'v' } },
	{ '<F2>', ui_select.test, mode = { 'n', 'i', 'v' } },
	{ '<F3>', vim.cmd.term('echo hello'), mode = { 'n', 'i', 'v' } },
	-- vim.keymap.set({'n', 'v', 'i'}, "<F5>", "<cmd>term ./build.sh<cr>")
})

local function get_visual_selection()
	local s_start = vim.fn.getpos('\'<')
	local s_end = vim.fn.getpos('\'>')
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	-- return table.concat(lines, '\n')
	vim.print(table.concat(lines, '\n'))
end
