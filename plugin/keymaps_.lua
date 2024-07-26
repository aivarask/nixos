wk.add {
  { '<leader>l', group = 'LSP,LG,LF', icon = '💎' },
  { '<leader>li', [[:LspInfo<CR>]], desc = 'LspInfo' },
  { '<leader>ll', [[:LspLog<CR>]], desc = 'LspLog' },
  { '<leader>lc', LspLogClear, desc = 'LspLogClear' },
  { '<leader>lr', [[:LspRestart<CR>]], desc = 'LspRestart' },
  { '<leader>lg', [[:LazyGit<CR>]], desc = 'LazyGit' },
  { '<leader>lf', [[:LfCurrentDirectory<CR>]], desc = 'LfCurrentDirectory' },
  { '<leader>lt', [[:LfNewTab<CR>]], desc = 'LfNewTab' },
  { '<leader>lw', [[:LfWorkingDirectory<CR>]], desc = 'LfWorkingDirectory' },
}

RunClear = function()
  neo.output_panel.clear()
  neo.run.run { strategy = 'dap' }
end

RunLastDap = function()
  neo.output_panel.clear()
  neo.run.run_last { strategy = 'dap' }
end

local neo = require 'neotest'
wk.add {
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
  { '<leader>gp', function() vim.cmd(p .. h .. '.pkgs.php81Packages.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'php81Packages' },
  { '<leader>gP', function() vim.cmd(p .. h .. '.pkgs.php81Extensions.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'php81Extensions' },
  { '<leader>gv', function() vim.cmd(p .. h .. '.pkgs.vimPlugins.' .. w() .. '.meta.homepage | xargs xdg-open') end, desc = 'vimPlugins' },
  { '<leader>gt', function() print 'foo' end, desc = 'test' },
}
