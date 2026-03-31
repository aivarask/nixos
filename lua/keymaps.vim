let g:bclose_no_plugin_maps=1
let no_vim_maps = 1

nmap q <Nop>
nmap Q <Nop>
nnoremap <silent> <Plug>(Save) :silent write<cr>
nnoremap ZQ :q!<CR>
nmap <M-q> :Bclose<cr>
nmap <leader>Q :%bd\|e#<cr>
nnoremap <silent> <leader>q :Bclose!<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>

nnoremap <silent> ]= :tabnext<CR>
nnoremap <silent> [- :tabprevious<CR>
nnoremap <silent> ]] :bnext<CR>
nnoremap <silent> [[ :bprevious<CR>
nnoremap <silent> [<BS> :b#<cr>
nnoremap <silent> ]<BS> :b#<cr>
nnoremap <silent> ]\ :wincmd w<CR>
nnoremap <silent> [' :wincmd p<CR>

nnoremap ` :split \| terminal<CR>

tnoremap <silent> ]] <cmd>bnext<CR>
tnoremap <silent> [[ <cmd>bprevious<CR>
tnoremap <Esc> <C-\><C-N>
tnoremap ` <C-\><C-N><C-W>:hide<CR>

if has('nvim')
	nnoremap // :Telescope live_grep<CR>
	nnoremap /. :Telescope find_files<CR>
else
	nnoremap // :Rg<CR>
	nnoremap /. :Files<CR>
	nmap qq <cmd>NERDTreeToggle<CR>
	nmap qQ <cmd>NERDTreeFind<CR>
	nnoremap <F5> :source $XDG_CONFIG_HOME/vim/vimrc<CR>
	nnoremap <silent> <leader><leader> :<C-U>WhichKey '\' '\'<CR>
	nnoremap <silent> <leader> :<C-U>WhichKey '\'<CR>
	nnoremap <silent> ] :<C-U>WhichKey ']'<CR>
	cnoremap <nowait> <Esc>h <Left>
	cnoremap <nowait> <Esc>l <Right>
endif

if has('nvim')
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
else
	nnoremap <leader><leader>c :Commands<CR>
	nnoremap <leader><leader>f :Files<CR>
	nnoremap <leader><leader>g :Rg<CR>
	nnoremap <leader><leader>h :Helptags<CR>
	nnoremap <leader><leader>k :Maps<CR>
endif
nnoremap <M-K> :m .-2<CR>==
nnoremap <M-J> :m .+1<CR>==
inoremap <M-J> <Esc>:m .+1<CR>==gi
inoremap <M-K> <Esc>:m .-2<CR>==gi
vnoremap <M-J> :m '>+1<CR>gv=gv
vnoremap <M-K> :m '<-2<CR>gv=gv
" CTRL-W    delete word to the left of cursor
" CTRL-O D  delete everything to the right of cursor
" CTRL-U    delete everything to the left of cursor
" CTRL-H    backspace/delete
" CTRL-J    insert newline (easier than reaching for the return key)
" CTRL-T    indent current line
" CTRL-D    un-indent current line

