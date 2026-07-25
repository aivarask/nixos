uv = vim.uv

-- vim.keymap.set({'n', 'i'}, '<LeftRelease>', function()
--     mouse_click("buffer")
-- end, {buffer = popup_buffer})

-- setups {{{
require("flatten").setup({ integrations = { kitty = true } })
require("kitty-scrollback").setup({
	search = {
		callbacks = {
			after_ready = function()
				vim.api.nvim_feedkeys("?", "n", false)
			end,
		},
	},
})

if vim.uv.os_getenv("WAYLAND_DISPLAY") then
	require("image").setup({ backend = "kitty" })
end
-- require('fidget').setup({})
-- require('notify').setup({ top_down = false, })
-- vim.notify = require('notify')
-- }}}
-- rest {{{
local function BufLsps()
	local separator = ""
	local lsps = ""
	for index, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		lsps = client.config.name .. lsps
		if client:supports_method("textDocument/formatting") then
			lsps = lsps .. "[F]"
		end
		lsps = lsps .. separator
	end
	return lsps
end

local function Shorten()
	local p = vim.fn.expand("%:p")
	return p:gsub("/nix/store/[%a%d]+-", ""):gsub(vim.uv.cwd() .. "/" or "", "")
end
--}}}
-- lspattach {{{
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp:attach", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/implementation") then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end

		vim.g.hover = false
		if client:supports_method("textDocument/hover") then
			vim.api.nvim_create_autocmd("CursorHold", {
				group = vim.api.nvim_create_augroup("lsp:hover", { clear = true }),
				buffer = args.buf,
				callback = function(ev)
					if vim.g.hover == true then
						vim.lsp.buf.hover({
							silent = true,
							focus = false,
							relative = "editor",
							-- anchor_bias = 'below', -- relative to cursor
							max_width = math.ceil(vim.o.columns / 2),
							max_height = vim.o.lines,
							offset_x = vim.o.columns,
							offset_y = vim.fn.line("w$") - 5,
						})
					end
				end,
			})
		end

		if client:supports_method("textDocument/codeLens") then
		end

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				convert = function(item)
					return { abbr = item.label:gsub("%b()", "") }
				end,
			})
		end

		if client:supports_method("textDocument/signatureHelp") then
		end

		if client:supports_method("textDocument/formatting") then
			-- client:supports_method('textDocument/willSaveWaitUntil')
			vim.api.nvim_create_autocmd({
				"InsertLeave",
				-- 'TextChanged',
				-- 'CompleteDone',
				"BufWritePre",
			}, {
				group = vim.api.nvim_create_augroup("lsp:format", { clear = false }),
				buffer = args.buf,
				callback = function()
					local ft = vim.fn.getbufvar(args.buf, "&filetype")
					vim.lsp.buf.format({
						bufnr = args.buf,
						id = client.id,
						-- timeout_ms = 1000,
						-- async = true
					})
				end,
			})
		end
	end,
})
-- }}}
-- lsp {{{
vim.o.pumheight = 16
vim.o.pumblend = 30
vim.o.complete = ".,w,o"
vim.o.autocomplete = true
vim.o.completeopt = "fuzzy,menu,menuone,noselect,popup"
-- vim.o.wildmode = "noselect,list:lastused"
-- vim.o.wildoptions = "exacttext,fuzzy,pum"
-- vim.o.wildignorecase = true
vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})
-- nixd {{{
vim.lsp.config.nixd = {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix" },
	settings = {
		nixd = {
			nixpkgs = {
				-- expr = "import <nixpkgs> { }",
			},
			formatting = { command = { "nixfmt" } },
			options = {
				nixos = {
					expr = '(builtins.getFlake (builtins.toString /etc/nixos)).nixosConfigurations.'
					    .. uv.os_gethostname()
					    .. ".type.getSubOptions []",
				},
				home_manager = {
					expr = '(builtins.getFlake ( builtins.toString /etc/nixos)).nixosConfigurations.'
					    .. uv.os_gethostname()
					    .. ".options.home-manager.users.type.getSubOptions []",
				},
			},
			diagnostic = {
				suppress = {
					"sema-extra-with",
					"sema-unused-def-let",
					"sema-unused-def-lambda-noarg-formal",
				},
			},
		},
	},
}
vim.lsp.enable("nixd")
-- }}}
-- bashls {{{
vim.lsp.config.bashls = {
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'bash', 'sh' }
}
vim.lsp.enable("bashls")
--}}}
-- typescript {{{
vim.lsp.config.typescript_ls = {
	filetypes = { 'javascript', 'typescript' },
	-- https://github.com/microsoft/TypeScript
	-- https://github.com/typescript-language-server/typescript-language-server
	cmd = { 'typescript-language-server', '--stdio' },
	-- root_dir = vim.fs.root(0, { 'package.json' }),
	init_options = { hostInfo = 'neovim' },
	settings = {
		completions = {
			completeFunctionCalls = true
		}
	}
}
vim.lsp.enable('typescript_ls')

-- }}}
-- vscode_json {{{
vim.lsp.config.vscode_json = {
	cmd = { 'vscode-json-languageserver', '--stdio' },
	filetypes = { 'json', 'jsonc' },
	init_options = {
		provideFormatter = true
	},
	settings = {
		json = {
			validate = { enable = true },
			format = { enable = true },
			schemas = require('schemastore').json.schemas({
				select = {
					'.eslintrc',
					'prettierrc.json',
					'package.json',
					'jsconfig.json',
					'tsconfig.json',
					'composer.json',
				},
				extra = {
					{
						fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
						name = 'snippets',
						url =
						'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
					},
				},
			}),
		},
	},
}
vim.lsp.enable("vscode_json")


-- }}}
-- yaml_ls {{{
vim.lsp.config.yaml_ls = {
	cmd = { 'yaml-language-server', '--stdio' },
	filetypes = { 'yaml' },
	settings = {
		-- https://github.com/redhat-developer/yaml-language-server#language-server-settings
		yaml = {
			format = { enable = true },
			schemaStore = { enable = true },
			schemas = require('schemastore').yaml.schemas(),
		},
	},
}
vim.lsp.enable("yaml_ls")

-- }}}
-- lua_ls {{{
local library = {
	vim.env.VIMRUNTIME,
}


local path = {
	'lua/?/init.lua',
	'lua/?.lua',
	--
	'?/init.lua',
	'?.lua',
}

local pathStrict = true

for i = #library, 1, -1 do
	local value = library[i]
	if string.find(value, 'myNeovimPackages') then
		table.remove(library, i)
	end
end
for _, name in ipairs({
	-- 'plenary.nvim',
}) do
	for _, v in ipairs(vim.api.nvim_list_runtime_paths()) do
		if string.find(v, name) then
			table.insert(library, v)
		end
	end
end

vim.lsp.config.lua_ls = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			completion = {
				autoRequire = true,
				callSnippet = 'Disable',
				displayContext = 7,
				enable = true,
				keywordSnippet = 'Both',
				postfix = '@',

			},
			diagnostics = { -- luals.github.io/wiki/diagnostics
				disable = { 'lowercase-global', 'unudirsed-local', 'unused-vararg', 'unused-function', 'need-check-nil', 'empty-block', 'missing-fields' },
				globals = { "mp", "client", "root", "screen" },
				ignoredFiles = "Disable"
			},
			format = {
				enable = true
			},
			hint = {
				enable = true,
				arrayIndex = 'Auto',
				setType = true,
			},
			runtime = {
				version = 'LuaJIT',
				pathStrict = pathStrict,
				path = path,
			},
			workspace = {
				checkThirdParty = false, -- https://luals.github.io/wiki/settings/#workspacecheckthirdparty
				library = library,
				-- library = vim.api.nvim_list_runtime_paths(),
				preloadFileSize = 600,
				ignoreDir = { 'node_modules', 'vendor', 'mpv/scripts' },
				-- https://luals.github.io/wiki/settings/#workspaceuserthirdparty
				userThirdParty = {},
			},
		},
	}
}
vim.lsp.enable("lua_ls")
-- }}}

-- }}}
-- diagnostics {{{
vim.lsp.inlay_hint.enable(false)
local severity = {
	min = vim.diagnostic.severity.WARN,
	max = vim.diagnostic.severity.ERROR,
}
vim.diagnostic.config({
	underline = { severity = severity },
	virtual_text = { severity = severity },
	-- virtual_lines = { severity = severity },
	virtual_lines = false,

	signs = true,
	float = {
		-- scope = 'buffer',
		-- pos = { 10, 10 },
		-- severity = severity
	},
	status = { severity = severity },
	update_in_insert = true,
	severity_sort = true,

	jump = {
		severity = severity,
		wrap = true,
	},
	loclist = {
		open = false,
		severity = severity,
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("diagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float({
			scope = "buffer",
			close_events = { "CursorMoved" },
			severity = severity,
			foo = "",
			pos = { 30, 30 },
			focusable = false,
		})
	end,
})

if false then
	vim.diagnostic.handlers.loclist = {
		show = function(_, _, _, opts)
			---@diagnostic disable-next-line: undefined-field
			opts.loclist.open = opts.loclist.open or false
			local winid = vim.api.nvim_get_current_win()
			---@diagnostic disable-next-line: undefined-field
			vim.diagnostic.setloclist(opts.loclist)
			vim.api.nvim_set_current_win(winid)
		end,
		hide = function(namespace, bufnr) end,
	}
end
-- }}}
