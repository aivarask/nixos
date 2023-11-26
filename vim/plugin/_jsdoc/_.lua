-- https://jsdoc.app/
-- https://github.com/heavenshell/vim-jsdoc/
vim.g.jsdoc_lehre_path = 'lehre'
wkr({
  name = 'JsDoc',
  ['?'] = {
    v = { [[:!xdg-open 'https://github.com/heavenshell/vim-jsdoc' <CR>]], '@gh/vim-jsdoc' },
    j = { [[:!xdg-open https://jsdoc.app <CR>]], 'www.jsdoc.app' },
  },
  j = { [[:JsDoc<CR>]], ':JsDoc' },
  f = { [[:JsDocFormat<CR>]], ':JsDocFormat' },
  J = { [[O/** */ <ESC>Bi]], 'JsDoc snippet' },
  t = {
    name = '$types',
    l = { [[a @type {import('./$types').LayoutServerLoad} <ESC>Bi]], '@type {import("./$types").LayoutServerLoad}' },
  },
  k = {
    name = 'kit',

    l = { [[aimport('@sveltejs/kit').LoadEvent <ESC>]], 'kit LoadEvent' },
    a = { [[aimport('@sveltejs/kit').Action <ESC>]], 'kit Action' },
  },
}, { prefix = '<leader>j' })
