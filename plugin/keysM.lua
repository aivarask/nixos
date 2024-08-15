vim.cmd [[
map <M--> :wincmd <<CR>
tmap <M--> <C-\><C-n>:wincmd <<CR>
map <M-=> :wincmd ><CR>
tmap <M-=> <C-\><C-n>:wincmd ><CR>
]]


wk.add {
  -- <M-k> lsp_signature toggle_key
  -- <M-s> lsp-overloads close_signature
  -- <M-s> switch
  -- <M-w> https//github.com/windwp/nvim-autopairs#fastwrap
  { '<M-1>',  '<cmd>Telescope find_files default_text=Make\\ |\\ .mk<CR>', mode = { 'n', 'i', }, },
  { '<M-2>',  '<cmd>:Telescope find_files default_text=dsl\\ <CR>',        mode = { 'n', 'i', }, },
  { '<M-c>',  '<cmd>Commentary<CR>',                                       mode = { 'n', 'i', 'v', }, },
  { '<M-E>1', '<cmd>edit .luarc.json<CR>', },
  { '<M-E>i', '<cmd>edit init.lua<CR>', },
  { '<M-E>k', '<cmd>edit plugin/keys.lua<CR>', },
  { '<M-E>l', '<cmd> plugin/lua.lua<CR>', },
}


wk.add {
  { '?a', function() wk.show {} end,                  desc = 'all', },
  { '??', function() wk.show { global = false, } end, desc = 'w/o global', },
  { '?i', function() wk.show { mode = 'i', } end,     desc = 'i', },
  { '?n', function() wk.show { mode = 'n', } end,     desc = 'n', },
  { '?v', function() wk.show { mode = 'v', } end,     desc = 'v', },
  { '?c', function() wk.show { mode = 'c', } end,     desc = 'c', },
  { '?z', function() wk.show { keys = '/', } end,     desc = 'z', },
}
