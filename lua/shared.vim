" terminal {{{
if !has('nvim') | set term=kitty | endif
set termguicolors
if &term =~ '256color' | set t_ut= | endif
if !has('gui_running') | set t_Co=256 guioptions-=e |endif
let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
augroup terminals
	au!
	" autocmd TermOpen,WinEnter "term://*" startinsert  
augroup END
function Term(arg = "zsh") abort
	echom a:arg
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
command! -bang -nargs=* Term call Term(<f-args>)
"tmap <silent> ` <C-w>:Term<cr>
nmap <silent> ` :Term<CR>
nmap <silent> <C-`> :Term lazygit<CR>
tmap <silent> ` <C-\><C-N><C-W>:Term<CR>
tmap <Esc> <C-\><C-N>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" }}}

" undo {{{
if has('nvim') | let g:self='nvim' | else | let g:self='vim' | endif  
execute "set undodir=".$XDG_STATE_HOME."/". g:self . "/undo"
call mkdir(&undodir, "p", 0700)
set undofile
" }}}

" session {{{
let g:session_dir=$XDG_STATE_HOME."/". g:self."/sessions/"
call mkdir(g:session_dir, "p", 0700)
let g:session_file=g:session_dir . substitute(getcwd(), "/","+", "g")
set sessionoptions=buffers,curdir,folds,help,tabpages,options,localoptions
augroup sessions
	autocmd!
	" autocmd VimEnter * if filereadable( g:session_file) | exe 'source ' . g:session_file | endif
	" autocmd VimLeave,FocusLost * silent exe 'mksession! ' . g:session_file
augroup	END
" }}}

" io {{{
set foldmethod=marker
set noswapfile
set updatetime=400
set autoread
set breakindent
set wrap
set sidescrolloff=8
augroup reads
	au!
	autocmd FocusLost,InsertLeave,TextChanged * if empty(&buftype) && &readonly == 0 | update | echom strftime("%H:%M") 'update' | endif
	" autocmd FileType * autocmd FocusLost,InsertLeave <buffer> if...
	autocmd FocusGained,CursorHold,CursorHoldI * if empty(&buftype) | checktime | endif
	autocmd BufWritePost *kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
augroup END
" }}}

" cmdline {{{
set wildmode=noselect:lastused,full
set wildoptions=pum
set wildignorecase
set wildcharm=<C-Z>
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>
cnoremap <nowait> <Esc>h <Left>
cnoremap <nowait> <Esc>l <Right>
" cmap <expr> <C-T> wildmenumode() ? "echo yes" : "echo no"
cmap <expr> <C-T> pumvisible() ? (complete_info().selected == -1 ? '<C-y><CR>' : '<C-y>') : '<CR>'

augroup wild
	autocmd!
	autocmd CmdlineChanged [:\/\?] call wildtrigger()
augroup END
command! SC vnew | setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile | nnoremap <buffer> ,s :silent %source<CR> 
command! DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
"cnoremap ss so /etc/nixos/lua/*.vim<C-Z>
" nnoremap <buffer> ,<CR> :silent %y\|@b<CR>
" }}}

" settings {{{
syntax on
filetype plugin indent on
set showtabline=2
set statusline=%n\ %f:%l:%c\ %L\ %m\ %r\ %y\ %q\ 
"set shortmess=filnxToOScF
"set shortmess=ltToOCF
set shortmess=aoOstTWAIcCFS
set hidden
set completeopt=menu,menuone,noselect
set mouse=a
set mousefocus
set lazyredraw
set modeline
set noshowmode
set splitkeep=topline
set splitbelow
set background=dark
set timeoutlen=500
set conceallevel=2
set clipboard=unnamedplus
set scrolloff=8
set cmdheight=2
set shiftround
set gdefault
set ignorecase
set smartcase
set whichwrap+=<,>,[,]
let g:sqlite_clib_path = $SQLITE_CLIB_PATH
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" }}}

" status {{{
function! SpawnBufferLine()
	let s = ''
	" Making a tab list on the right side
	for i in range(1, tabpagenr('$'))  " Loop through the number of tabs
		let s .= (i == tabpagenr()) ? ('%#TabLineSel#') : ('%#TabLine#')
		let s .= '%' . i . 'T '  " set the tab page number (for mouse clicks)
		let s .= i . ' '          " set page number string
	endfor
	let s .= '%#TabLineFill#%T'  " Reset highlight
	if tabpagenr('$') > 1
		let s .= '%999X X '
	endif
	" Get the list of buffers. Use bufexists() to include hidden buffers
	let bufferNums = filter(range(1, bufnr('$')), 'buflisted(v:val)')
	for i in bufferNums
		let s .= (i == bufnr()) ? ('%#TabLineSel#') : ('%#TabLine#')
		let s .=' ' . i . '' 
		if bufname(i) == ''
			let s .= '[No Name]'
		endif
		if getbufvar(i, "&modifiable")
			let s .= fnamemodify(bufname(i), ':t') 
			" let s .= pathshorten(bufname(i)) 
			let s .= (getbufvar(i, "&modified")) ? ('+') : ('')
		else
			let s .= fnamemodify(bufname(i), ':t') . '-'
		endif
		let s .= ' '
	endfor
	" let s .= '%#TabLineFill#%T'  " Reset highlight
	let s .= '%=' " Spacer
	return s
endfunction
set tabline=%!SpawnBufferLine()  " Assign the tabline
" }}}
