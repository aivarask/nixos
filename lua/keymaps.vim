let g:bclose_no_plugin_maps=1
let g:no_vim_maps=1

nmap q <Nop>
nmap Q <Nop>
nnoremap <silent> <Plug>(Save) :silent write<cr>
nnoremap ZQ :q!<CR>
nmap <M-Q> :<cr>
nmap <leader>Q :%bd\|e#<cr>
nnoremap <silent> <leader>q :bd!<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>

nnoremap <silent> ]= :tabnext<CR>
nnoremap <silent> [- :tabprevious<CR>
map <silent> ]] :bnext<CR>
map <silent> [[ :bprevious<CR>
tmap <silent> ]] <C-\><C-N>:bnext<CR>
tmap <silent> [[ <C-\><C-N>:bprevious<CR>

nnoremap <silent> [<BS> :b#<CR>
nnoremap <silent> ]<BS> :b#<CR>
nnoremap <silent> ]\ :wincmd w<CR>
nnoremap <silent> [' :wincmd p<CR>

inoremap jk <Esc>



inoremap <M-S-B> msb
"inoremap <M-N> mN
inoremap <M-S-N> msN

inoremap <M-n> mn

inoremap <M-j> <C-O><Down>
inoremap <M-k> <C-O><Up>





nnoremap <M-K> :m .-2<CR>==
nnoremap <M-J> :m .+1<CR>==
inoremap <M-J> <Esc>:m .+1<CR>==gi
inoremap <M-K> <Esc>:m .-2<CR>==gi
vnoremap <M-J> :m '>+1<CR>gv=gv
vnoremap <M-K> :m '<-2<CR>gv=gv

" let scroll=8
 "map <Space> 8<C-E>
" map <S-Space> 8<C-Y>
" imap <C-Space> 

function Term(arg = "zsh") abort
	let tname = '!' . a:arg
	if has('nvim') | let tname = 'term:/' | endif
	let bnr = bufnr(tname)
	let wnr = bufwinnr(tname)
	if wnr > 0 && winnr('$') > 1
		execute wnr . 'wincmd c'
	elseif bnr > 0 && bnr != bufnr(@%)
		execute 'sb ' . bnr
	elseif bnr == bufnr(@%)
		execute 'bprevious | sb ' . bnr . ' | wincmd p'
	else
		if has('nvim') | execute 'sb | edit term://' . a:arg | else | execute 'terminal ++close ' . a:arg | endif
	endif
endfunction
command! -bang -nargs=* Term call Term()

"tmap <silent> ` <C-w>:Term<cr>
nmap <silent> ` :Term<CR>
nmap <silent> <C-`> :Term lazygit<CR>
tmap <silent> ` <C-\><C-N><C-W>:Term<CR>
tmap <Esc> <C-\><C-N>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>

if has('nvim')
	"autocmd! nvim.terminal TermClose
	nnoremap // :Telescope live_grep<CR>
	nnoremap /. :Telescope find_files<CR>
	nnoremap /, :execute 'terminal lf ' .. expand("%:h")<CR>
else
	nnoremap qq :Lexplore<CR>
	nnoremap // :Rg<CR>
	nnoremap /. :Files<CR>
	nnoremap <F5> :source $XDG_CONFIG_HOME/vim/vimrc<CR>

	" nnoremap <silent> <leader><leader> :<C-U>WhichKey '\' '\'<CR>
	" nnoremap <silent> <leader> :<C-U>WhichKey '\'<CR>
	" nnoremap <silent> ] :<C-U>WhichKey ']'<CR>
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

