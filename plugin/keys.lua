-- NOTE: https://vi.stackexchange.com/questions/22129/which-keys-are-free-unmapped-by-default-in-vim
wk = require "which-key"
wk.setup { preset = 'helix', sort = { "alphanum" } }
wk.add {
  { '-',      [[:cd ..<CR>]],                                          desc = 'cd ..' },
  { '<F1>',   function() vim.cmd.help(vim.fn.expand '<cword>') end,    desc = 'help <cword>' },
  { '<M-0>',  [[:edit plugin/keys.lua<CR>]],                        desc = 'edit keymaps.lua' },
  { '<M-1>',  [[:Telescope find_files default_text=Make\ |\ .mk<CR>]], desc = 'find_files Make .mk' },
  { '<M-2>',  [[:Telescope find_files default_text=dsl\ <CR>]],        desc = 'find_files dsl' },
  { '<M-D>',  [[:Telescope find_files default_text=dsl\ <CR>]],        desc = 'find_files dsl' },
  { '<M-e>c', [[:e composer.json<CR>]],                                desc = 'composer.json' },
  { '<M-e>l', [[:e dsl/lua.lua<CR>]],                                  desc = 'lua.lua' },
  { '<M-e>p', [[:e package.json<CR>]],                                 desc = 'package.json' },
  { '??',     function() wk.show { global = false } end,               desc = 'wk.show global = false' },
  { '?a',     function() wk.show {} end,                               desc = 'wk.show' },
}

todo = require 'todo-comments'
todo.setup {}
wk.add {
  { '<leader>c', group = 'todo-comments', icon = '✅' },
  { '<leader>c[', todo.jump_prev, desc = 'jump_prev' },
  { '<leader>c]', todo.jump_next, desc = 'jump_next' },
  { '<leader>cc', [[:TodoTrouble<CR>]], desc = 'TodoTrouble' },
  { '<leader>cd', todo.disable, desc = 'disable' },
  { '<leader>ce', todo.enable, desc = 'enable' },
  { '<leader>cl', [[:TodoLocList<CR>]], desc = 'TodoLocList' },
  { '<leader>cq', [[:TodoQuickFix<CR>]], desc = 'TodoQuickFix' },
}

dap = require 'dap'
dapui = require 'dapui'
widgets = require 'dap.ui.widgets'
require 'persistent-breakpoints'.setup { load_breakpoints_event = { "BufReadPost" } }
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
  { '<leader>dX', function() widgets.centered_float(widgets.scopes) end, desc = 'widgets.scopes' },
  { '<leader>dz', dap.close, desc = 'close' },
  { '<leader>dZ', dap.terminate, desc = 'terminate' },
}

local p = [[!nix eval nixos\#nixosConfigurations.]]
local h = vim.uv.os_gethostname()
local w = function() return vim.fn.expand '<cword>' end
string.open = function(v) vim.cmd('!xdg-open ' .. v) end
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

gitsigns = require 'gitsigns'
gitsigns.setup { signcolumn = false }
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
  { '<leader>lc', function() io.popen('echo > ' .. vim.lsp.get_log_path()) end, desc = 'LspLogClear' },
  { '<leader>lf', [[:LfCurrentDirectory<CR>]], desc = 'LfCurrentDirectory' },
  { '<leader>lg', [[:LazyGit<CR>]], desc = 'LazyGit' },
  { '<leader>li', [[:LspInfo<CR>]], desc = 'LspInfo' },
  { '<leader>ll', [[:LspLog<CR>]], desc = 'LspLog' },
  { '<leader>lr', [[:LspRestart<CR>]], desc = 'LspRestart' },
  { '<leader>lt', [[:LfNewTab<CR>]], desc = 'LfNewTab' },
  { '<leader>lw', [[:LfWorkingDirectory<CR>]], desc = 'LfWorkingDirectory' },
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

require 'hover'.setup { init = function() require 'hover.providers.lsp' end } -- hover-nvim
require 'goto-preview'.setup {}                                               -- goto-preview
wk.add {
  { '<leader>p', group = 'goto-preview', icon = '🔍' },
  { '<leader>pd', require 'goto-preview'.goto_preview_definition, desc = 'definition' },
  { '<leader>pt', require 'goto-preview'.goto_preview_type_definition, desc = 'type_definition' },
  { '<leader>pi', require 'goto-preview'.goto_preview_implementation, desc = 'implementation' },
  { '<leader>pD', require 'goto-preview'.goto_preview_declaration, desc = 'declaration' },
  { '<leader>pc', require 'goto-preview'.close_all_win, desc = 'close_all_win' },
  { '<leader>pr', require 'goto-preview'.goto_preview_references, desc = 'references' },
}

neotest = require 'neotest'
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

require 'telescope'.setup { defaults = { layout_strategy = 'vertical', layout_config = { vertical = { width = 0.9 } } } }
require 'telescope'.load_extension 'dap'
require 'telescope'.load_extension 'fzf'
local ff = require 'telescope.builtin'.find_files
wk.add {
  { '<leader>t',   group = 'Telescope' },
  { '<leader>ta',  [[:Telescope autocommands<CR>]],                   desc = 'autocommands' },
  { '<leader>tB',  [[:Telescope buffers <CR>]],                       desc = 'buffers' },
  { '<leader>tC',  [[:Telescope commands<cr> ]],                      desc = 'commands' },
  { '<leader>te',  [[:Telescope symbols<cr> ]],                       desc = 'emoji symbols' },
  { '<leader>tf',  [[:Telescope find_files<CR>]],                     desc = 'find_files' },
  { '<leader>tg',  [[:Telescope live_grep<CR>]],                      desc = 'live_grep' },
  { '<leader>th',  [[:Telescope help_tags<CR>]],                      desc = 'helptags' },
  { '<leader>tk',  [[:Telescope keymaps<CR>]],                        desc = 'keymaps' },
  { '<leader>tl',  group = 'LSP' },
  { '<leader>tld', [[:Telescope lsp_document_symbols<CR>]],           desc = 'lsp_document_symbols' },
  { '<leader>tlw', [[:Telescope lsp_workspace_symbols<CR>]],          desc = 'lsp_workspace_symbols' },
  { '<leader>tlx', [[:Telescope lsp_dynamic_workspace_symbols<CR>]],  desc = 'lsp_dynamic_workspace_symbols' },
  { '<leader>tn',  function() ff { cwd = '/etc/nixos' } end,          desc = 'find /etc/nixos' },
  { '<leader>tp',  [[:Telescope ak paths<CR>]],                       desc = 'ak paths' },
  { '<leader>tr',  [[:Telescope registers<CR>]],                      desc = 'registers' },
  { '<leader>ts',  function() ff { cwd = '/etc/nixos/snippets' } end, desc = 'find snippets' },
  { '<leader>tt',  [[:Telescope<CR>]],                                desc = 'Telescope' },
}

-- TODO: trouble-nvim configuration
trouble = require 'trouble'
trouble.setup {}
wk.add {
  { '<leader>x', group = 'Trouble', icon = '🚩' },
  { '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'diagnostics %' },
  { '<leader>xc', '<cmd>Trouble todo toggle<cr>', desc = 'todo-comments' },
  { '<leader>xd', '<cmd>Trouble diagnostics toggle<cr>', desc = 'diagnostics' },
  { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'loclist' },
  { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'lsp' }, -- TODO: err no results for lsp, sounds interesting
  { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'qflist' },
  { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'symbols' },
  { '<leader>xx', '<cmd>Trouble<cr>', desc = 'Trouble' },
}

require 'toggleterm'.setup {
  shade_terminals = false,
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * 0.4
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.3
    end
  end,
  -- open_mapping = [[<c-\>]],
  float_opts = {
    width = function() return math.ceil(vim.o.columns * 0.8) end,
    height = function() return math.ceil(vim.o.lines * 0.8) end,
  },
}
local Terminal = require 'toggleterm.terminal'.Terminal
nix_repl = Terminal:new { cmd = 'nix repl', hidden = true }
lazygit = Terminal:new { cmd = "lazygit", hidden = true }
wk.add {
  { '<leader>a', group = 'ToggleTerm', icon = '🚧' },
  { '<leader>af', "<cmd>ToggleTerm direction=float <CR>", desc = 'float', mode = { 'n', 'i', 't' } },
  { '<leader>ah', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'horizontal', mode = { 'n', 'i', 't' } },
  { '<leader>an', '<cmd>lua nix_repl:toggle()<cr>', desc = 'nix repl' },
  { '<leader>al', '<cmd>lua lazygit:toggle()<cr>', desc = 'lazygit' },
  { '<leader>aR', "<cmd>exec 'ToggleTerm direction=tab dir=' .. expand('%:p:h')<CR>", desc = 'relative tab', mode = { 'n', 'i', 't' } },
  { '<leader>ar', "<cmd>exec 'ToggleTerm direction=vertical dir=' .. expand('%:p:h')<CR>", desc = 'relative vertical', mode = { 'n', 'i', 't' } },
  { '<leader>at', '<cmd>ToggleTerm direction=tab<CR>', desc = 'tab', mode = { 'n', 'i', 't' } },
  { '<leader>av', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'vertical', mode = { 'n', 'i', 't' } },
}
vim.api.nvim_create_augroup('ToggleTermKeymaps', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'ToggleTermKeymaps',
  desc = 'keymap.set on filetype toggleterm',
  pattern = 'toggleterm',
  callback = function()
    local opts = { buffer = 0 }
    -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<F11>', [[<cmd>LazyGit<CR>]], opts)
  end,
})
