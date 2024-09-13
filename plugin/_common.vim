let g:bclose_no_plugin_maps=1
nnoremap <silent> <M-q> :Bclose<CR>
nnoremap <M-Q> :Bclose!<CR>

let g:lf_map_keys = 0

if !has('nvim')
	let g:floaterm_autoclose = 2
	let g:floaterm_height = 0.7
	let g:floaterm_width = 0.8
	let g:floaterm_wintype = 'float'
	nnoremap <F12> :FloatermToggle<CR>
	tnoremap <F12> <C-W>:FloatermToggle<CR>
	let g:AutoPairsFlyMode = 1
	let g:AutoPairsShortcutBackInsert = '<C-b>'
else
	set undodir=$HOME/.vim/undo
	set undofile
	set noswapfile
endif

if has('termguicolors')
	set termguicolors
endif
set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
