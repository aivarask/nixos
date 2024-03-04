require('which-key').register({
  ['<F11>'] = { [[:LazyGit<CR>]], 'LazyGit' },
  ['<M-e>'] = { [[:Telescope find_files<CR>]], 'find_files' },
  ['<M-1>'] = { [[:Telescope find_files default_text=Make\ |\ .mk<CR>]], 'find_files make' },
  ['<M-2>'] = { [[:Telescope find_files default_text=dsl\ <CR>]], 'dsl' },
  --
  ['<M-0>'] = { [[:edit plugin/keymaps.lua<CR>]], 'edit keymaps.lua' },
  ['-'] = { [[:cd ..<CR>]], 'cd ..' },
  ['<F1>'] = { function() vim.cmd.help(vim.fn.expand('<cword>')) end, 'help <cword>' },
  ['<F13>'] = { function() vim.cmd.help(vim.fn.expand('<cWORD>')) end, 'help <cWORD>' },
  ['<F25>'] = { function() vim.cmd.help(vim.fn.expand('<cexpr>')) end, 'help <cexpr>' },
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

-- alacritty

string.open = function(v)
  vim.cmd('!xdg-open ' .. v)
end

require('which-key').register({
  d = { function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.description | xargs notify-send') end, 'description' },
  D = { function() vim.cmd(p .. h .. '.pkgs.' .. w() .. [[.meta.longDescription --raw | xargs -0 notify-send]]) end, 'longDescription' },
  -- "github:nix-community/neovim-nightly-overlay";
  g = { function() vim.fn.expand('<cWORD>'):gsub('github:', 'https://github.com/'):gsub(';', ''):open() end, 'github:owner/repo' },
  h = { function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'meta.homepage' },
  l = { function() vim.cmd(p .. h .. '.pkgs.luajitPackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'meta.homepage' },
  m = { function() vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. vim.fn.expand('<cword>') .. '"') end, 'meta.homepage' },
  n = { function() vim.cmd(p .. h .. '.pkgs.nodePackages.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'nodePackages' },
  p = { function() vim.cmd(p .. h .. '.pkgs.php81Packages.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'php81Packages' },
  P = { function() vim.cmd(p .. h .. '.pkgs.php81Extensions.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'php81Extensions' },
  v = { function() vim.cmd(p .. h .. '.pkgs.vimPlugins.' .. w() .. '.meta.homepage | xargs xdg-open') end, 'vimPlugins' },
  t = { function()
    print(string)
  end, 'test' },
}, { prefix = '<leader>g' })
