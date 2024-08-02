-- https://vi.stackexchange.com/questions/22129/which-keys-are-free-unmapped-by-default-in-vim
dap = require 'dap'
dapui = require 'dapui'
widgets = require 'dap.ui.widgets'
neotest = require 'neotest'
gitsigns = require 'gitsigns'
gitsigns.setup { signcolumn = false }

function LspLogClear()
  io.popen('echo > ' .. vim.lsp.get_log_path())
  vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
end

local p = [[!nix eval nixos\#nixosConfigurations.]]
local h = vim.uv.os_gethostname()
local w = function() return vim.fn.expand '<cword>' end
string.open = function(v) vim.cmd('!xdg-open ' .. v) end

require 'persistent-breakpoints'.setup {
  load_breakpoints_event = { "BufReadPost" },
}

wk.add {
  { '<leader>d', group = 'DAP', icon = '🐞' },
  { '<leader>da', dap.attach, desc = 'attach' },
  { '<leader>dB', dap.step_back, desc = 'step_back' },
  { '<leader>db', group = 'breakpoint', icon = '🔴' },
  { '<leader>dbc', dap.clear_breakpoints, desc = 'clear_breakpoints' },
  { '<leader>dbl', dap.list_breakpoints, desc = 'list_breakpoints' },
  { '<leader>dbs', dap.set_breakpoint, desc = 'set_breakpoint' },
  { '<leader>dbt', dap.toggle_breakpoint, desc = 'toggle_breakpoint' },
  { '<leader>dbx', dap.set_exception_breakpoints, desc = 'set_exception_breakpoints' },
  { '<leader>dc', dap.continue, desc = 'continue' },
  { '<leader>dC', dap.reverse_continue, desc = 'reverse_continue' },
  { '<leader>dd', dap.disconnect, desc = 'disconnect' },
  { '<leader>df', group = 'frame', icon = '🎞️' },
  { '<leader>dff', dap.focus_frame, desc = 'focus_frame' },
  { '<leader>dfr', dap.restart_frame, desc = 'restart_frame' },
  { '<leader>dg', dap.goto, desc = 'goto' },
  { '<leader>dL', dap.launch, desc = 'launch' },
  { '<leader>dl', dap.run_last, desc = 'run_last' },
  { '<leader>dp', dap.pause, desc = 'pause' },
  { '<leader>dR', dap.restart, desc = 'restart' },
  { '<leader>dr', dap.run, desc = 'run' },
  { '<leader>dS', dap.status, desc = 'status' },
  { '<leader>ds', group = 'step', icon = '🔀' },
  { '<leader>dsh', dap.step_out, desc = 'out' },
  { '<leader>dsj', dap.step_over, desc = 'over' },
  { '<leader>dsk', dap.step_back, desc = 'back' },
  { '<leader>dsl', dap.step_into, desc = 'into' },
  { '<leader>dT', dap.repl.toggle, desc = 'repl.toggle' },
  { '<leader>dt', function() dapui.toggle { reset = true } end, desc = 'dapui.toggle' },
  { '<leader>dU', dap.down, desc = 'down' },
  { '<leader>du', dap.up, desc = 'up' },
  { '<leader>dw', widgets.hover, desc = 'widgets.hover' },
  { '<leader>dW', widgets.preview, desc = 'widgets.preview' },
  { '<leader>dx', dap.run_to_cursor, desc = 'run_to_cursor' },
  { '<leader>dX', function () widgets.centered_float(widgets.scopes)  end, desc = 'widgets.scopes' },
  { '<leader>dz', dap.close, desc = 'close' },
  { '<leader>dZ', dap.terminate, desc = 'terminate' },
}
wk.add {
  { '<leader>g', group = 'xdg-open', icon = '🔗' },
  { '<leader>gc', function() vim.cmd([[!composer browse ]] .. vim.fn.expand '<cWORD>':gsub(':', '')) end, desc = 'composer browse' },
  { '<leader>gd', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.description | xargs notify-send') end, desc = 'description' },
  { '<leader>gD', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. [[.meta.longDescription --raw | xargs -0 notify-send]]) end, desc = 'longDescription' },
  { '<leader>gg', function() vim.fn.expand '<cWORD>':gsub('github:', 'https://github.com/'):gsub(';', ''):open() end, desc = 'github:owner/repo' },
  { '<leader>gh', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'meta.homepage' },
  { '<leader>gl', function() vim.cmd(p .. h .. '.pkgs.luajitPackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'luajitPackages' },
  { '<leader>gm', function() vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. vim.fn.expand '<cword>' .. '"') end, desc = 'mynixos' },
  { '<leader>gn', function() vim.cmd(p .. h .. '.pkgs.nodePackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'nodePackages' },
  { '<leader>gP', function() vim.cmd(p .. h .. '.pkgs.php81Extensions.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'php81Extensions' },
  { '<leader>gp', function() vim.cmd(p .. h .. '.pkgs.php81Packages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'php81Packages' },
  { '<leader>gv', function() vim.cmd(p .. h .. '.pkgs.vimPlugins.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'vimPlugins' },
}

wk.add {
  { '<leader>h', group = 'gitsigns', icon = '🤩' },
  { '<leader>hb', function() gitsigns.blame_line { full = true } end, desc = 'blame_line' },
  { '<leader>hB', gitsigns.toggle_current_line_blame, desc = 'toggle_current_line_blame' },
  { '<leader>hD', function() gitsigns.diffthis '~' end, desc = 'diffthis ~' },
  { '<leader>hd', gitsigns.diffthis, desc = 'diffthis' },
  { '<leader>hi', [[:<C-U>Gitsigns select_hunk<CR>]], desc = 'select_hunk', mode = { 'o', 'x' } },
  { '<leader>hn', function() gitsigns.nav_hunk 'next' end, desc = 'Hunk next' },
  { '<leader>hn', gitsigns.nav_hunk, desc = 'nav_hunk' },
  { '<leader>hp', function() gitsigns.nav_hunk 'prev' end, desc = 'Hunk prev' },
  { '<leader>hp', gitsigns.preview_hunk, desc = 'preview_hunk' },
  { '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = 'reset_hunk', mode = 'v' },
  { '<leader>hR', gitsigns.reset_buffer, desc = 'reset_buffer' },
  { '<leader>hr', gitsigns.reset_hunk, desc = 'reset_hunk' },
  { '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = 'stage_hunk', mode = 'v' },
  { '<leader>hS', gitsigns.stage_buffer, desc = 'stage_buffer' },
  { '<leader>hs', gitsigns.stage_hunk, desc = 'stage_hunk' },
  { '<leader>htd', gitsigns.toggle_deleted, desc = 'toggle_deleted' },
  { '<leader>hu', gitsigns.undo_stage_hunk, desc = 'undo_stage_hunk' },
}

wk.add {
  { '<leader>l', group = 'LSP,LG,LF', icon = '💎' },
  { '<leader>lc', LspLogClear, desc = 'LspLogClear' },
  { '<leader>lf', [[:LfCurrentDirectory<CR>]], desc = 'LfCurrentDirectory' },
  { '<leader>lg', [[:LazyGit<CR>]], desc = 'LazyGit' },
  { '<leader>li', [[:LspInfo<CR>]], desc = 'LspInfo' },
  { '<leader>ll', [[:LspLog<CR>]], desc = 'LspLog' },
  { '<leader>lr', [[:LspRestart<CR>]], desc = 'LspRestart' },
  { '<leader>lt', [[:LfNewTab<CR>]], desc = 'LfNewTab' },
  { '<leader>lw', [[:LfWorkingDirectory<CR>]], desc = 'LfWorkingDirectory' },
}

wk.add {
  { '<leader>n', group = 'neotest', icon = '🧪' },
  { '<leader>nB', function() neotest.run.run { vim.fn.expand '%', strategy = 'dap' } end, desc = '% dap' },
  { '<leader>nb', function() neotest.run.run(vim.fn.expand '%') end, desc = '%' },
  { '<leader>nc', neotest.output_panel.clear, desc = 'output_panel.clear' },
  { '<leader>nL', function() neotest.run.run_last { strategy = 'dap' } end, desc = 'run_last dap' },
  { '<leader>nl', function() neotest.run.run_last() end, desc = 'run_last' },
  { '<leader>no', neotest.output_panel.toggle, desc = 'output_panel.toggle' },
  { '<leader>nR', function() neotest.run.run { strategy = 'dap' } end, desc = 'run dap' },
  { '<leader>ns', function() neotest.run.run { suite = true } end, desc = 'suite' },
  { '<leader>nS', function() neotest.run.run { suite = true, strategy = 'dap' } end, desc = 'suite dap' },
  { '<leader>nt', neotest.watch.toggle, desc = 'watch.toggle' },
  { '<leader>nW', neotest.watch.stop, desc = 'watch.stop' },
  { '<leader>nw', neotest.watch.watch, desc = 'watch.watch' },
  { '<leader>nx', function() neotest.summary:expand(vim.uv.cwd(), true) end, desc = 'summary:expand' },
  { '<leader>nX', function() neotest.summary:toggle() end, desc = 'summary:toggle' },
}

wk.add {
  { '<space>', group = 'LSP', icon = '🤖' },
  { '<space>a', vim.lsp.buf.code_action, desc = 'code_action', mode = { 'n', 'v' } },
  { '<space>D', vim.lsp.buf.declaration, desc = 'declaration' },
  { '<space>d', vim.lsp.buf.definition, desc = 'definition' },
  { '<space>e', vim.diagnostic.open_float, desc = 'open_float' },
  { '<space>I', inspect_lsp_client, desc = 'Inspect LSP' },
  { '<space>i', vim.lsp.buf.implementation, desc = 'implementation' },
  { '<space>O', [[<cmd>LspOverloadsSignature<CR>]], desc = 'LspOverloadsSignature' },
  { '<space>o', [[<cmd>Outline<CR>]], desc = 'Outline' },
  { '<space>q', vim.diagnostic.setloclist, desc = 'setloclist' },
  { '<space>R', vim.lsp.buf.references, desc = 'references' },
  { '<space>r', vim.lsp.buf.rename, desc = 'rename' },
  { '<space>S', require 'lsp_signature'.toggle_float_win, desc = 'toggle_float_win' },
  { '<space>s', vim.lsp.buf.signature_help, desc = 'signature_help' },
  { '<space>t', vim.lsp.buf.type_definition, desc = 'type_definition' },
}

wk.add {
  { '-',      [[:cd ..<CR>]],                                          desc = 'cd ..' },
  { '<F1>',   function() vim.cmd.help(vim.fn.expand '<cword>') end,    desc = 'help <cword>' },
  { '<M-0>',  [[:edit plugin/keymaps.lua<CR>]],                        desc = 'edit keymaps.lua' },
  { '<M-1>',  [[:Telescope find_files default_text=Make\ |\ .mk<CR>]], desc = 'find_files Make .mk' },
  { '<M-2>',  [[:Telescope find_files default_text=dsl\ <CR>]],        desc = 'find_files dsl' },
  { '<M-D>',  [[:Telescope find_files default_text=dsl\ <CR>]],        desc = 'find_files dsl' },
  { '<M-e>c', [[:e composer.json<CR>]],                                desc = 'composer.json' },
  { '<M-e>l', [[:e dsl/lua.lua<CR>]],                                  desc = 'lua.lua' },
  { '<M-e>p', [[:e package.json<CR>]],                                 desc = 'package.json' },
  { '??',     function() wk.show { global = false } end,               desc = 'wk.show global = false' },
  { '?a',     function() wk.show {} end,                               desc = 'wk.show' },
}

