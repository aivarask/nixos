vim.lsp.inlay_hint.enable(false)
vim.diagnostic.config({
	underline = { severity = { min = 1, max = 4 } },
	virtual_text = { severity = { min = 1, max = 4 } },
	virtual_lines = { severity = { min = vim.diagnostic.severity.ERROR } },
	loclist = {
		open = false,
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	update_in_insert = true,
})


vim.diagnostic.handlers.loclist = {
	show = function(_, _, _, opts)
		---@diagnostic disable-next-line: undefined-field
		opts.loclist.open = opts.loclist.open or false
		local winid = vim.api.nvim_get_current_win()
		---@diagnostic disable-next-line: undefined-field
		vim.diagnostic.setloclist(opts.loclist)
		vim.api.nvim_set_current_win(winid)
	end
}


if false then
	vim.api.nvim_create_user_command('DiagnosticQf', function(args)
		if args.args == 'ERROR' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
		elseif args.args == 'WARN' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
		elseif args.args == 'INFO' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
		else
			vim.diagnostic.setqflist({})
		end
	end, {
		desc = 'Adds lsp diagnostic to the Quickfix list',
		complete = function() return { 'ERROR', 'WARN', 'HINT', 'INFO' } end,
		nargs = '?',
	})

	vim.api.nvim_create_user_command('DiagnosticLoc', function(args)
		if args.args == 'ERROR' then
			vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
		elseif args.args == 'WARN' then
			vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.WARN })
		elseif args.args == 'HINT' then
			vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.HINT })
		elseif args.args == 'INFO' then
			vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.INFO })
		else
			vim.diagnostic.setloclist({})
		end
	end, {
		desc = 'Adds lsp diagnostic to the Quickfix list',
		complete = function() return { 'ERROR', 'WARN', 'HINT', 'INFO' } end,
		nargs = '?',
	})
end
