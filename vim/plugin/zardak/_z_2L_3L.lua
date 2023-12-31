wkr({
  name = '2L',
  -- " https://github.com/junegunn/fzf.vim#commands
  F = { [[:FZF<CR>]], ':FZF' },
  G = { [[:Rg <C-r><C-w><CR>]], ':Rg <C-r><C-w>' },
  H = { [[:Rg https<CR>]], ':Rg https url links' },
  M = { [[:Maps<CR>]], ':Maps' },
  ['/'] = { [[:History/<CR>]], ':History/' },
  [':'] = { [[:History:<CR>]], ':History:' },
  [']'] = { neotest.output_panel.toggle, 'neotest.output_panel.toggle' },
  a = { [[:call _#save_and_exec()<CR>]], ':call _#save_and_exec()' },
  b = { [[:Buffers<CR>]], ':Buffers' },
  c = { [[:Commands<CR>]], ':Commands' },
  d = { dapui.toggle_reset, 'dapui.toggle_reset' },
  f = { [[:Files<CR>]], ':Files' },
  g = { [[:Rg<CR>]], ':Rg' },
  h = { [[:Helptags<CR>]], ':Helptags' },
  j = { [[:Jumps<CR>]], ':Jumps' },
  m = { [[:Marks<CR>]], ':Marks' },
  n = { [[:Files /etc/nixos<CR>]], ':Files /etc/nixos' },
  v = { [[:Files /etc/nixos/vim<CR>]], ':Files /etc/nixos/vim' },
}, { prefix = '<leader><leader>' })

wkr({
  name = '3L',
  [']'] = { '<cmd>SymbolsOutline<cr>' },
  ['1'] = { '<cmd>e languages/en.yml<cr>' },
  ['2'] = { '<cmd>e languages/lt.yml<cr>' },
  ['8'] = { '<cmd>e src/app.d.ts<cr>' },
  ['9'] = { '<cmd>e src/app.postcss<cr>' },
  ['p'] = { '<cmd>e package.json<cr>' },
  --
}, { prefix = '<leader><leader><leader>' })
