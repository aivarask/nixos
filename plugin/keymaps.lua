-- https://vi.stackexchange.com/questions/22129/which-keys-are-free-unmapped-by-default-in-vim
require('which-key').register({
  ['<M-e><M-e>'] = { [[:Telescope find_files<CR>]], 'find_files .' },
  ['<M-e>c'] = { [[:e composer.json<CR>]], 'composer.json' },
  ['<M-e>p'] = { [[:e package.json<CR>]], 'package.json' },
  ['<M-1>'] = { [[:Telescope find_files default_text=Make\ |\ .mk<CR>]], 'find_files Make .mk' },
  ['<M-2>'] = { [[:Telescope find_files default_text=dsl\ <CR>]], 'find_files dsl' },
  --
  ['<M-0>'] = { [[:edit plugin/keymaps.lua<CR>]], 'edit keymaps.lua' },
  ['<M-n>'] = { [[:edit plugin/neotest.lua<CR>]], 'edit neotest.lua' },
  ['<M-d>'] = { [[:edit plugin/dap.lua<CR>]], 'edit dap.lua' },
  ['<M-p>'] = { [[:edit dsl/php.lua<CR>]], 'edit php.lua' },
  ['-'] = { [[:cd ..<CR>]], 'cd ..' },
  ['??'] = { [[:WhichKey<CR>]], 'WhichKey' },
  ['<leader>['] = { function() return require('dapui').toggle({ reset = true }) end, 'dapui toggle' },
  ['<leader>]'] = { [[:Neotest summary<CR>]], 'Neotest summary' },
  ['<leader>}'] = { [[:Neotest output-panel<CR>]], 'Neotest output-panel' },
  ['<leader>a'] = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },
  ['<leader>A'] = { [[:AerialToggle<CR>]], 'AerialToggle' },
  ['<F1>'] = { function() vim.cmd.help(vim.fn.expand('<cword>')) end, 'help <cword>' },
  ['<F13>'] = { function() vim.cmd.help(vim.fn.expand('<cWORD>')) end, 'help <cWORD>' },
  ['<F25>'] = { function() vim.cmd.help(vim.fn.expand('<cexpr>')) end, 'help <cexpr>' },
  -- ./dap.lua F4-F8
  ['<F4>'] = { function() require('neotest').run.run({ vim.fn.expand('%') }) end, 'neotest %' },
  ['<F26>'] = { function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, 'neotest % dap' },
  ['<F38>'] = { function() require('neotest').run.run({ suite = true }) end, 'neotest % dap' },
  ['<F5>'] = { require('dap').continue, 'dap continue' },
  ['<F17>'] = { require('dap').terminate, 'dap terminate' }, -- <S-F5>
  ['<F29>'] = { require('osv').launch({}), 'osv launch' },   -- <S-F5>
  ['<F7>'] = { function() require('dapui').toggle({ reset = true }) end, 'dapui.toggle_reset' },
  ['<F8>'] = { require('dap').toggle_breakpoint, 'toggle_breakpoint' },
  ['<F20>'] = { require('dap').list_breakpoints, 'dap list_breakpoints' }, -- <S-F8>
  --
  ['<F10>'] = { [[:Telescope session-lens<CR>]], "session-lens" },
  ['<F22>'] = { [[:Autosession delete<CR>]], "Autosession delete" },
  ['<F11>'] = { [[:LazyGit<CR>]], 'LazyGit' },
})



function LspLogClear()
  io.popen('echo > ' .. vim.lsp.get_log_path())
  vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
end

LspLogClear()

require('which-key').register({
  name = 'Lsp,LazyGit,Lf',
  i = { [[:LspInfo<CR>]], 'LspInfo' },
  l = { [[:LspLog<CR>]], 'LspLog' },
  c = { LspLogClear, 'LspLogClear' },
  r = { [[:LspRestart<CR>]], 'LspRestart' },
  g = { [[:LazyGit<CR>]], 'LazyGit' },
  f = { [[:LfCurrentDirectory<CR>]], 'LfCurrentDirectory' },
  t = { [[:LfNewTab<CR>]], 'LfNewTab' },
  w = { [[:LfWorkingDirectory<CR>]], 'LfWorkingDirectory' },
}, { prefix = '<leader>l' })



local p = [[!nix eval nixos\#nixosConfigurations.]]
local h = vim.uv.os_gethostname()
local w = function() return vim.fn.expand('<cword>') end

string.open = function(v)
  vim.cmd('!xdg-open ' .. v)
end

require('which-key').register({
  c = { function() vim.cmd([[!composer browse ]] .. vim.fn.expand('<cWORD>'):gsub(':', '')) end, 'composer browse' },
  d = { function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.description | xargs notify-send') end, 'description' },
  D = { function() vim.cmd(p .. h .. '.pkgs.' .. w() .. [[.meta.longDescription --raw | xargs -0 notify-send]]) end, 'longDescription' },
  -- "github:nix-community/neovim-nightly-overlay";
  g = { function() vim.fn.expand('<cWORD>'):gsub('github:', 'https://github.com/'):gsub(';', ''):open() end, 'github:owner/repo' },
  h = { function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'meta.homepage' },
  l = { function() vim.cmd(p .. h .. '.pkgs.luajitPackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'luajitPackages' },
  m = { function() vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. vim.fn.expand('<cword>') .. '"') end, 'mynixos' },
  n = { function() vim.cmd(p .. h .. '.pkgs.nodePackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'nodePackages' },
  p = { function() vim.cmd(p .. h .. '.pkgs.php81Packages.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'php81Packages' },
  P = { function() vim.cmd(p .. h .. '.pkgs.php81Extensions.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'php81Extensions' },
  v = { function() vim.cmd(p .. h .. '.pkgs.vimPlugins.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'vimPlugins' },
  t = { function()
    print(string)
  end, 'test' },
}, { prefix = '<leader>g' })
