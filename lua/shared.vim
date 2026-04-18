" hlsearch {{{
augroup AutoHighlighting
    au!
    autocmd CmdlineEnter /,\? set hlsearch
    autocmd CmdlineLeave /,\? set nohlsearch
augroup END
nnoremap <leader>h <cmd>set hlsearch!<cr>
" }}}

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
function! Term(arg = "zsh") abort
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
set sessionoptions=buffers,curdir,folds,help,tabpages,options
augroup sessions
	autocmd!
	 "autocmd VimEnter * if filereadable( g:session_file) | exe 'source ' . g:session_file | endif
	 "autocmd VimLeave,FocusLost * silent exe 'mksession! ' . g:session_file
augroup	END
function! SessionClear()
	call delete(v:this_session)
endfunction
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

" settings {{{
syntax on
filetype plugin indent on
set showtabline=2
set statusline=%n\ %f:%l:%c\ %L\ %m\ %r\ %y\ %q\ 
"set shortmess=filnxToOScF
"set shortmess=ltToOCF
set shortmess=aoOstTWAIcCF
set hidden
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

" cmdline {{{
set wildmode=noselect:lastused,full
set wildoptions=pum
set wildignorecase
set wildcharm=<C-Z>
augroup wild
	autocmd!
	" autocmd CmdlineChanged [:\/\?] call wildtrigger()
augroup END
command! SC vnew | setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile | nnoremap <buffer> ,s :silent %source<CR> 
command! DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
"cnoremap ss so /etc/nixos/lua/*.vim<C-Z>
" nnoremap <buffer> ,<CR> :silent %y\|@b<CR>
" cmap <expr> / pumvisible() ? (complete_info().selected == -1 ? '<C-y><Tab>' : '<C-y>') : '<CR>'
nnoremap <expr> <F2> Woo()
inoremap <expr> ?? Woo()
" cunmap <expr> <Tab> Woo()

function! Test()
	e lua/
endfunction


cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>
cnoremap <nowait> <Esc>h <Left>
cnoremap <nowait> <Esc>l <Right>

function! Woo()

	echom complete_info()
	" startinsert
	
	return "\<Ignore>"
endfunction

" }}}

" find {{{
set path=**
set wildignore+=**/.git/**

function! FindFuncGlob(cmdarg, cmdcomplete)
	let pat = a:cmdcomplete ? $'{a:cmdarg}*' : a:cmdarg
	return glob(pat, v:false, v:true)
endfunc

function! FindGitFiles(cmdarg, cmdcomplete)
	let fnames = systemlist('git ls-files')
	return fnames->filter('v:val =~? a:cmdarg')
endfunc

function! FindFiles(filename)
  let error_file = tempname()
  silent exe '!fd -t f '.a:filename.' | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
endfunction

command! -nargs=1 Find call FindFiles(<q-args>)
nmap /. :Find<space>
function! FindFunc(cmdarg, cmdcomplete)
    let files = glob("**", v:false, v:true)
    return a:cmdarg == '' ? files : matchfuzzy(files, a:cmdarg)
endfunc
set findfunc=FindFunc
set autocomplete
set autocompletetimeout=100
set autocompletedelay=300
let &l:complete = 'o,' . &l:complete
set completetimeout=100
set completeopt=menu,menuone,noselect
set completeopt+=fuzzy



" grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow	
function! Grep(...)
  return system(join([&grepprg] + a:000), ' ')
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr Grep(<f-args>)
nmap // :Grep<space>
"}}}

" tags {{{
"set tagfunc=ctags -R *
set tags=tags
" }}}

" netrw {{{
let g:netrw_keepdir = 0
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=-30
let g:netrw_preview=1
let g:netrw_wiw=0
let g:netrw_sizestyle="H"
let g:netrw_sort_options="i"
"}}}

if !has('nvim')
	packadd! editorconfig
	packadd! hlyank
	packadd! comment
	packadd! helpcurwin
	packadd! termdebug
else
	let g:loaded_python3_provider = 0
	let g:loaded_perl_provider = 0
endif

let g:which_key_vertical=1
" let g:no_vim_maps=1

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
tnoremap <silent> ]] <C-\><C-N>:bnext<CR>
tnoremap <silent> [[ <C-\><C-N>:bprevious<CR>

nnoremap <silent> [<BS> :b#<CR>
nnoremap <silent> ]<BS> :b#<CR>
nnoremap <silent> ]\ :wincmd w<CR>
nnoremap <silent> [' :wincmd p<CR>

inoremap jk <Esc>

inoremap <M-h> <C-O><Left>
inoremap <M-j> <C-O><Down>
inoremap <M-k> <C-O><Up>
inoremap <M-l> <C-O><Right>
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

nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>

"autocmd! nvim.terminal TermClose
nnoremap /, :execute 'terminal lf ' .. expand("%:h")<CR>
nnoremap qq :Lexplore<CR>
nnoremap // :Rg<CR>
nnoremap /. :Files<CR>
nnoremap <F5> :source $XDG_CONFIG_HOME/vim/vimrc<CR>
" nnoremap <silent> <leader><leader> :<C-U>WhichKey '\' '\'<CR>
" nnoremap <silent> <leader> :<C-U>WhichKey '\'<CR>
" nnoremap <silent> ] :<C-U>WhichKey ']'<CR>


