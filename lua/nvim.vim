if has('nvim')
	let g:loaded_python3_provider = 0
	let g:loaded_perl_provider = 0
	"set nofoldenable
	"set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
	" set foldmethod=expr
	" set foldclose=all
	"https://github.com/trygveaa/kitty-kitten-search?tab=readme-ov-file#usage set foldlevel=3
	" set foldnestmax=4
	" let &foldnestmax = &foldlevel+3
	" set foldminlines=3
endif

