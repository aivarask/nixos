if has('nvim')
	let g:loaded_python3_provider = 0
	let g:loaded_perl_provider = 0
	set sessionoptions=buffers,curdir,folds,help,tabpages,terminal,winpos,winsize
	set nofoldenable
	set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
	" set foldmethod=expr
	" set foldclose=all
	" set foldlevel=3
	" set foldnestmax=4
	" let &foldnestmax = &foldlevel+3
	" set foldminlines=3
endif

