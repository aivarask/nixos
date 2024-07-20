function LspLogClear()
  io.popen('echo > ' .. vim.lsp.get_log_path())
  vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
end

LspLogClear()
wk.add({
  { '<leader>l', group = 'LSP,LG,LF', icon = '💎' },
  { '<leader>li', [[:LspInfo<CR>]], desc = 'LspInfo' },
  { '<leader>ll', [[:LspLog<CR>]], desc = 'LspLog' },
  { '<leader>lc', LspLogClear, desc = 'LspLogClear' },
  { '<leader>lr', [[:LspRestart<CR>]], desc = 'LspRestart' },
  { '<leader>lg', [[:LazyGit<CR>]], desc = 'LazyGit' },
  { '<leader>lf', [[:LfCurrentDirectory<CR>]], desc = 'LfCurrentDirectory' },
  { '<leader>lt', [[:LfNewTab<CR>]], desc = 'LfNewTab' },
  { '<leader>lw', [[:LfWorkingDirectory<CR>]], desc = 'LfWorkingDirectory' },
})

local neo = require('neotest')
wk.add({
  { '<leader>n', group = 'Neotest', icon = '🧪' },
  { '<leader>ns', function() neo.run.run({ suite = true }) end, desc = 'suite' },
  { '<leader>nS', function() neo.run.run({ suite = true, strategy = 'dap' }) end, desc = 'suite dap' },
  { '<leader>nb', function() neo.run.run(vim.fn.expand('%')) end, desc = '%' },
  { '<leader>nB', function() neo.run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, desc = '% dap' },
  { '<leader>nr', function() neo.run.run() end, desc = 'run' },
  { '<leader>nR', function() neo.run.run({ strategy = 'dap' }) end, desc = 'run dap' },
  { '<leader>nl', function() neo.run.run_last() end, desc = 'run_last' },
  { '<leader>nL', function() neo.run.run_last({ strategy = 'dap' }) end, desc = 'run_last dap' },
  { '<leader>nx', function() neo.summary:expand(vim.uv.cwd(), true) end, desc = 'summary:expand' },
  { '<leader>nw', neo.watch.watch, desc = 'watch.watch' },
  { '<leader>nW', neo.watch.stop, desc = 'watch.stop' },
  { '<leader>nt', neo.watch.toggle, desc = 'watch.toggle' },
})
-- https://vi.stackexchange.com/questions/22129/which-keys-are-free-unmapped-by-default-in-vim
wk.add({
  ['<M-e><M-e>'] = { [[:Telescope find_files<CR>]], 'find_files .' },
  ['<M-e>c'] = { [[:e composer.json<CR>]], 'composer.json' },
  ['<M-e>p'] = { [[:e package.json<CR>]], 'package.json' },
  ['<M-e>l'] = { [[:e dsl/lua.lua<CR>]], 'lua.lua' },
  ['<M-1>'] = { [[:Telescope find_files default_text=Make\ |\ .mk<CR>]], 'find_files Make .mk' },
  ['<M-2>'] = { [[:Telescope find_files default_text=dsl\ <CR>]], 'find_files dsl' },
  ['<M-D>'] = { [[:Telescope find_files default_text=dsl\ <CR>]], 'find_files dsl' },
  --
  ['<M-0>'] = { [[:edit plugin/keymaps.lua<CR>]], 'edit keymaps.lua' },
  -- TDD
  ['<M-T>'] = { [[:Telescope find_files default_text=tdd\ <CR>]], 'find_files tdd' },
  ['<M-n>'] = { [[:edit tdd/~neotest.lua<CR>]], 'edit tdd/~neotest.lua' },
  ['<M-d>'] = { [[:edit tdd/_dap.lua<CR>]], 'edit tdd/_dap.lua' },
  ['-'] = { [[:cd ..<CR>]], 'cd ..' },
  ['??'] = { [[:WhichKey<CR>]], 'WhichKey' },
  ['qa'] = { "<leader>[", "dapui toggle", noremap = false },
  ['<leader>['] = { function() return require('dapui').toggle({ reset = true }) end, 'dapui toggle' },
  ['<leader>]'] = { [[:Neotest summary<CR>]], 'Neotest summary' },
  -- [']<leader>'] = { [[:Neotest output-panel<CR>]], 'Neotest output-panel' },
  [']<leader>'] = { function()
    require('neotest').output_panel.toggle()
  end, 'Neotest output-panel' },
  ['<leader>a'] = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },
  ['<leader>A'] = { [[:AerialToggle<CR>]], 'AerialToggle' },
  ['<F1>'] = { function() vim.cmd.help(vim.fn.expand('<cword>')) end, 'help <cword>' },
  ['<F13>'] = { function() vim.cmd.help(vim.fn.expand('<cWORD>')) end, 'help <cWORD>' },
  ['<F25>'] = { function() vim.cmd.help(vim.fn.expand('<cexpr>')) end, 'help <cexpr>' },
  -- ./dap.lua F4-F8
  -- ['<F4>'] = { function() require('neotest').run.run({ vim.fn.expand('%') }) end, 'neotest %' },
  -- ['<F26>'] = { function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, 'neotest % dap' },
  -- ['<F38>'] = { function() require('neotest').run.run({ suite = true }) end, 'neotest % dap' },
  ['<F5>'] = { require('dap').continue, 'dap continue' },
  ['<F17>'] = { require('dap').terminate, 'dap terminate' }, -- <S-F5>
  ['<F29>'] = { require('dap').terminate, 'dap terminate' }, -- <C-F5>
  ['<F6>'] = { function()
    require('neotest').output_panel.clear()
    require('neotest').run.run({ strategy = 'dap' })
  end, 'neotest run.run dap' },
  ['<F7>'] = { function()
    require('neotest').output_panel.clear()
    require('neotest').run.run_last({ strategy = 'dap' })
  end, 'neotest run.run_last dap' },
  -- ['<F29>'] = { function() require('osv').launch({ port = 8086 }) end, 'osv launch' }, -- <C-F5>
  -- ['<F6>'] = { function() require('osv').run_this({ port = 8086 }) end, 'osv run_this' },
  -- ['<F7>'] = { function() require('dapui').toggle({ reset = true }) end, 'dapui.toggle_reset' },
  ['<F8>'] = { require('dap').toggle_breakpoint, 'toggle_breakpoint' },
  ['<F20>'] = { require('dap').list_breakpoints, 'dap list_breakpoints' },   -- <S-F8>
  ['<F32>'] = { require('dap').clear_breakpoints, 'dap.clear_breakpoints' }, -- <C-F8>
  --
  ['<F10>'] = { [[:Telescope session-lens<CR>]], "session-lens" },
  ['<F22>'] = { [[:Autosession delete<CR>]], "Autosession delete" },
  ['<F11>'] = { [[:LazyGit<CR>]], 'LazyGit' },
  ['<leader><leader>r'] = { function() require('plenary.reload').reload_module(vim.fn.expand('%')) end, 'plenary.reload.reload_module' },
  -- ['<leader><leader>z'] = { function() require('plenary.reload').reload_module(vim.fn.expand('%')) end, 'plenary.reload.reload_module' },
})

local p = [[!nix eval nixos\#nixosConfigurations.]]
local h = vim.uv.os_gethostname()
local w = function() return vim.fn.expand('<cword>') end

string.open = function(v)
  vim.cmd('!xdg-open ' .. v)
end

wk.add({
  { '<leader>g', group = 'xdg-open', icon = '🔗' },
  { '<leader>gc', function() vim.cmd([[!composer browse ]] .. vim.fn.expand('<cWORD>'):gsub(':', '')) end, desc = 'composer browse' },
  { '<leader>gd', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.description | xargs notify-send') end, desc = 'description' },
  { '<leader>gD', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. [[.meta.longDescription --raw | xargs -0 notify-send]]) end, desc = 'longDescription' },
  { '<leader>gg', function() vim.fn.expand('<cWORD>'):gsub('github:', 'https://github.com/'):gsub(';', ''):open() end, desc = 'github:owner/repo' },
  { '<leader>gh', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'meta.homepage' },
  { '<leader>gl', function() vim.cmd(p .. h .. '.pkgs.luajitPackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'luajitPackages' },
  { '<leader>gm', function() vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. vim.fn.expand('<cword>') .. '"') end, desc = 'mynixos' },
  { '<leader>gn', function() vim.cmd(p .. h .. '.pkgs.nodePackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'nodePackages' },
  { '<leader>gp', function() vim.cmd(p .. h .. '.pkgs.php81Packages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'php81Packages' },
  { '<leader>gP', function() vim.cmd(p .. h .. '.pkgs.php81Extensions.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'php81Extensions' },
  { '<leader>gv', function() vim.cmd(p .. h .. '.pkgs.vimPlugins.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'vimPlugins' },
  { '<leader>gt', function() print(string) end, desc = 'test' },
})
