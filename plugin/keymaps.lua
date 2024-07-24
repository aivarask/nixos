-- https://vi.stackexchange.com/questions/22129/which-keys-are-free-unmapped-by-default-in-vim
dap = require('dap')
dapui = require('dapui')
neo = require('neotest')
wk.add({
  { group = 'Alt', icon = '💤' },
  { '<M-e>c', [[:e composer.json<CR>]], desc = 'composer.json' },
  { '<M-e>p', [[:e package.json<CR>]], desc = 'package.json' },
  { '<M-e>l', [[:e dsl/lua.lua<CR>]], desc = 'lua.lua' },
  { '<M-1>', [[:Telescope find_files default_text=Make\ |\ .mk<CR>]], desc = 'find_files Make .mk' },
  { '<M-2>', [[:Telescope find_files default_text=dsl\ <CR>]], desc = 'find_files dsl' },
  { '<M-D>', [[:Telescope find_files default_text=dsl\ <CR>]], desc = 'find_files dsl' },
  { '<M-0>', [[:edit plugin/keymaps.lua<CR>]], desc = 'edit keymaps.lua' },
  { '-', [[:cd ..<CR>]], desc = 'cd ..' },
  { '??', function() wk.show({ global = false }) end, desc = 'wk.show global = false' },
  { '?a', function() wk.show({}) end, desc = 'wk.show' },
  { '<leader>[', function() return dapui.toggle({ reset = true }) end, desc = 'dapui toggle' },
  { '<leader>]', '<leader>nX', desc = 'summary', remap = true },
  { ']<leader>', neo.output_panel.toggle, desc = 'output-panel' },
  { '<leader>a', [[:SymbolsOutline<CR>]], desc = 'SymbolsOutline' },
  { '<leader>A', [[:AerialToggle<CR>]], desc = 'AerialToggle' },
  { '<F1>', function() vim.cmd.help(vim.fn.expand('<cword>')) end, desc = 'help <cword>' },
  { '<F13>', function() vim.cmd.help(vim.fn.expand('<cWORD>')) end, desc = 'SF1 help <cWORD>' },
  { '<F25>', function() vim.cmd.help(vim.fn.expand('<cexpr>')) end, desc = 'CF1 help <cexpr>' },
  { '<F4>', '<leader>n', desc = 'Neotest', remap = true },
  { '<F26>', '<leader>nB', desc = 'neo % dap', remap = true },
  { '<F38>', '<leader>nS', desc = 'neo suite dap', remap = true },
  { '<F5>', '<leader>dc', desc = 'dap.continue' },
  { '<F17>', '<leader>dT', desc = 'dap.terminate' },
  { '<F6>', '<leader>nr', desc = 'neotest dap', remap = true },
  { '<F7>', RunLastDap, desc = 'neo run_last dap' },
  { '<F8>', dap.toggle_breakpoint, desc = 'toggle_breakpoint' },
  { '<F20>', dap.list_breakpoints, desc = 'SF8 list_breakpoints' },   -- SF8
  { '<F32>', dap.clear_breakpoints, desc = 'CF8 clear_breakpoints' }, -- CF8
  { '<F10>', [[:Telescope session-lens<CR>]], desc = "session-lens" },
  -- { '<F23>', [[:Autosession delete<CR>]], desc = "Autosession delete" },
})
