if has('nvim')
	let g:loaded_python3_provider = 0
	let g:loaded_perl_provider = 0
	set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos
	set nofoldenable
	set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
	" set foldmethod=expr
	" set foldclose=all
	" set foldlevel=3
	" set foldnestmax=4
	" let &foldnestmax = &foldlevel+3
	" set foldminlines=3

	nnoremap <leader>b :b<Space>

	nnoremap<leader><leader><leader>a :Telescope autocommands<CR>
	nnoremap<leader><leader><leader>b :Telescope buffers<CR>
	nnoremap<leader><leader><leader>c :Telescope commands<CR>
	nnoremap<leader><leader><leader>d :Telescope diagnostics<CR>
	nnoremap<leader><leader><leader>f :Telescope find_files<CR>
	nnoremap<leader><leader><leader>g :Telescope live_grep<CR>
	nnoremap<leader><leader><leader>h :Telescope help_tags<CR>
	nnoremap<leader><leader><leader>H :Telescope command_history<CR>
	nnoremap<leader><leader><leader>k :Telescope keymaps<CR>
	nnoremap<leader><leader><leader>R :Telescope reloader<CR>
	nnoremap<leader><leader><leader>r :Telescope registers<CR>
	nnoremap<leader><leader><leader>m :Telescope manix<CR>
	nnoremap<leader><leader><leader>t :Telescope resume<CR>
	nnoremap<leader><leader><leader><leader>T :Telescope<CR>

	nnoremap <M-h> :wincmd h<CR>
	nnoremap <M-j> :wincmd j<CR>
	nnoremap <M-k> :wincmd k<CR>
	nnoremap <M-l> :wincmd l<CR>
	tnoremap <M-h> <C-\><C-n>:wincmd h<CR>
	tnoremap <M-j> <C-\><C-n>:wincmd j<CR>
	tnoremap <M-k> <C-\><C-n>:wincmd k<CR>
	tnoremap <M-l> <C-\><C-n>:wincmd l<CR>
endif

