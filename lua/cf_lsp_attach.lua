vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp:attach', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end

		if client:supports_method('textDocument/hover') then
			vim.api.nvim_create_autocmd('CursorHold', {
				group = vim.api.nvim_create_augroup('lsp:hover', { clear = true }),
				buffer = args.buf,
				callback = function(ev)
					vim.lsp.buf.hover({
						silent = true,
						focus = false,
						relative = 'editor',
						-- anchor_bias = 'below', -- relative to cursor
						max_width = math.ceil(vim.o.columns / 2),
						max_height = vim.o.lines,
						offset_x = vim.o.columns,
						offset_y = vim.fn.line('w$') - 5,
					})
				end
			})
		end

		if client:supports_method('textDocument/codeLens') then
		end

		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				convert = function(item)
					return { abbr = item.label:gsub('%b()', '') }
				end,
			})
		end

		if client:supports_method('textDocument/signatureHelp') then
		end

		if client:supports_method('textDocument/formatting') then
			-- client:supports_method('textDocument/willSaveWaitUntil')
			vim.api.nvim_create_autocmd({
				'InsertLeave',
				-- 'TextChanged',
				-- 'CompleteDone',
				'BufWritePre'
			}, {
				group = vim.api.nvim_create_augroup('lsp:format', { clear = false }),
				buffer = args.buf,
				callback = function()
					local ft = vim.fn.getbufvar(args.buf, '&filetype')
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
