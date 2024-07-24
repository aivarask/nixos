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

RunClear = function()
  neo.output_panel.clear()
  neo.run.run({ strategy = 'dap' })
end

RunLastDap = function()
  neo.output_panel.clear()
  neo.run.run_last({ strategy = 'dap' })
end

local neo = require('neotest')
wk.add({
  { '<leader>n', group = 'Neotest', icon = '🧪' },
  { '<leader>ns', function() neo.run.run({ suite = true }) end, desc = 'suite' },
  { '<leader>nS', function() neo.run.run({ suite = true, strategy = 'dap' }) end, desc = 'suite dap' },
  { '<leader>nb', function() neo.run.run(vim.fn.expand('%')) end, desc = '%' },
  { '<leader>nB', function() neo.run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, desc = '% dap' },
  { '<leader>nr', RunClear, desc = 'run' },
  { '<leader>nR', function() neo.run.run({ strategy = 'dap' }) end, desc = 'run dap' },
  { '<leader>nl', function() neo.run.run_last() end, desc = 'run_last' },
  { '<leader>nL', function() neo.run.run_last({ strategy = 'dap' }) end, desc = 'run_last dap' },
  { '<leader>nx', function() neo.summary:expand(vim.uv.cwd(), true) end, desc = 'summary:expand' },
  { '<leader>nX', function() neo.summary:toggle() end, desc = 'summary:toggle' },
  { '<leader>nw', neo.watch.watch, desc = 'watch.watch' },
  { '<leader>nW', neo.watch.stop, desc = 'watch.stop' },
  { '<leader>nt', neo.watch.toggle, desc = 'watch.toggle' },
})

local p = [[!nix eval nixos\#nixosConfigurations.]]
local h = vim.uv.os_gethostname()
local w = function() return vim.fn.expand('<cword>') end
string.open = function(v) vim.cmd('!xdg-open ' .. v) end
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
  { '<leader>gt', function() print('foo') end, desc = 'test' },
})
