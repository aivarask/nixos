
if has('nvim')
    let g:loaded_python3_provider = 0
    let g:loaded_perl_provider = 0
	"autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
	set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos
	set nofoldenable
	" set foldmethod=expr
	set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
	" set foldclose=all
	" set foldlevel=3
	" set foldnestmax=4
	" let &foldnestmax = &foldlevel+3
	" set foldminlines=3
	set lisp

	nnoremap <leader>A :Telescope autocommands<CR>
	nnoremap <leader>b :b<Space>
	nnoremap <leader>` :Telescope buffers<CR>
	nnoremap <leader>c :Telescope commands<CR>
	nnoremap <leader>d :Telescope diagnostics<CR>
	nnoremap <leader>f :Telescope find_files<CR>
	nnoremap <leader>g :Telescope live_grep<CR>
	nnoremap <leader>h :Telescope help_tags<CR>
	nnoremap <leader>H :Telescope command_history<CR>
	nnoremap <leader>k :Telescope keymaps<CR>
	nnoremap <leader>R :Telescope reloader<CR>
	nnoremap <leader>r :Telescope registers<CR>
	nnoremap <leader>M :Telescope manix<CR>
	nnoremap <leader>t :Telescope resume<CR>
	nnoremap <leader>T :Telescope<CR>

	nnoremap <M-h> :wincmd h<CR>
	nnoremap <M-j> :wincmd j<CR>
	nnoremap <M-k> :wincmd k<CR>
	nnoremap <M-l> :wincmd l<CR>
	tnoremap <M-h> <C-\><C-n>:wincmd h<CR>
	tnoremap <M-j> <C-\><C-n>:wincmd j<CR>
	tnoremap <M-k> <C-\><C-n>:wincmd k<CR>
	tnoremap <M-l> <C-\><C-n>:wincmd l<CR>
endif

