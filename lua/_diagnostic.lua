if false then
	vim.diagnostic.config({
		float = true,
		severity_sort = true,
		virtual_lines = false,
		virtual_text = true
	})

	vim.api.nvim_create_user_command('DiagnosticQf', function(args)
		if args.args == 'ERROR' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
		elseif args.args == 'WARN' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
		elseif args.args == 'HINT' then
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
