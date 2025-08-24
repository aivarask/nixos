vim.o.pumheight = 16

vim.cmd [[set completeopt+=menuone,noselect,popup]]
-- vim.o.completeopt = "menu,menuone,nosort,preview"
-- vim.o.completeopt = "fuzzy,menu,menuone,noselect,preview"

vim.lsp.config('*', {
	root_markers = { '.git' },
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			}
		}
	}
})


vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp:attach', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end

		if client:supports_method('textDocument/hover') then
			vim.api.nvim_create_autocmd('CursorHold', {
				group = vim.api.nvim_create_augroup('lsp:hover', { clear = false }),
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

		if (not client:supports_method('textDocument/willSaveWaitUntil') or true)
				or client:supports_method('textDocument/formatting')
		then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('lsp:format', { clear = false }),
				buffer = args.buf,
				callback = function()
					local verbose = false
					if verbose then os.execute('notify-send ' .. os.time()) end
					local ft = vim.fn.getbufvar(args.buf, '&filetype')
					if ft == 'json' or ft == 'jsonc' then
						vim.lsp.buf.format({ name = 'jsonls' })
					elseif ft == 'markdown' then
						vim.lsp.buf.format({ name = 'marksman' })
					elseif ft == 'python' then
						vim.lsp.buf.format({ name = 'pylsp', bufnr = args.buf, id = client.id, timeout_ms = 1000 })
					elseif ft == 'php' then
						vim.lsp.buf.format({ name = 'phpls', bufnr = args.buf, id = client.id, timeout_ms = 1000 })
					else
						vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
					end
				end,
			})
		end
	end,
})



vim.lsp.inlay_hint.enable(false)
vim.lsp.enable({
	'bashls',
	'clangd',
	'gopls',
	'htmx-lsp',
	'jsonls',
	'luals',
	'marksman',
	'nixd',
	'phpls',
	'pylsp',
	-- 'pyright',
	-- 'rustls',
	-- 'sql',
	'stylelint',
	'templls',
	'tomlls',
	'typescript-language-server',
	-- 'twigls',
	'vscode-css',
	'vscode-html',
	'yamlls',
}, true)
