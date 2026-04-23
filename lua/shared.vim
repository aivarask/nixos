let g:loaded_matchit=1
let g:loaded_scriptease=1
let g:loaded_EditorConfig=1
let g:no_vim_maps=1

" ctrlp {{{
let g:ctrlp_map='<M-e>'
" let g:ctrlp_user_command='fd --full-path "\/etc\/nixos"'
" let g:ctrlp_user_command = 'find %s -type f' 
let g:ctrlp_user_command = 'fd --type f --hidden --color never "" %s'
let g:ctrlp_show_hidden = 1
" }}}
" inspect,debug {{{
set verbosefile="./verbose"
set verbose=0
" }}}
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
set ssop="blank,buffers,curdir,folds,help,tabpages,winpos,winsize,terminal"

"set sessionoptions=blank,buffers,curdir,folds,help,localoptions,options,skiprtp,resize,sesdir,tabpages,winpos,winsize
"set sessionoptions=blank,buffers,curdir,folds,help,localoptions,options,skiprtp,resize,sesdir,tabpages,winpos,winsize
" set sessionoptions+=globals,terminal
augroup sessions
	autocmd!
	 " autocmd VimEnter * Obsession
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
	autocmd FocusLost,InsertLeave,TextChanged * if empty(&buftype) && &readonly == 0 && !empty(&filetype) | update | echom 0 && strftime("%H:%M") 'update' | endif
	autocmd FileType * autocmd BufEnter <buffer> let b:did_add_maps=1
	autocmd FocusGained,CursorHold,CursorHoldI * if empty(&buftype) | checktime | endif
	autocmd BufWritePost *kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
augroup END
" }}}
" settings {{{
syntax on
filetype indent plugin on
"set shortmess=filnxToOScF
"set shortmess=ltToOCF
set shortmess=oOstTWAIcCF
set hidden
set mouse=a
set mousefocus
set lazyredraw
set modeline
set splitkeep=topline
set splitbelow
set background=dark
set timeoutlen=500
set conceallevel=2
set clipboard=unnamedplus
set scrolloff=8
set shiftround
set gdefault
set ignorecase
set smartcase
set whichwrap+=<,>,[,]
set previewheight=32
set previewwindow
let g:sqlite_clib_path = $SQLITE_CLIB_PATH
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
" }}}
" status {{{
set showtabline=2
set title titlestring=%{g:self}\ %{getcwd()}\ %f\ 
let &titleold=getcwd()
set statusline=%#Search#%h%w%q\ %n\ %.24f\ %l\/%L\ %m%r%y\ %{ObsessionStatus()}
" set statusline+=%S
set showmode
set cmdheight=2
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
"set tags=tags
" }}}

" PLUGINS {{{
" netrw {{{
"let g:netrw_keepdir = 0
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_winsize=15
" let g:netrw_winsize=-30
let g:netrw_preview=1
let g:netrw_wiw=4
let g:netrw_sizestyle="H"
let g:netrw_sort_options="i"
let g:netrw_mousemaps=0
" let g:netrw_list_hide=
let g:netrw_localmovecmd=0
" }}}
" packadd {{{
if !has('nvim')
	source $VIMRUNTIME/xdg.vim
	set rtp=$XDG_CONFIG_HOME/vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$XDG_CONFIG_HOME/vim/after"
	" packadd! editorconfig
	packadd! hlyank
	packadd! comment
	" packadd! helpcurwin
	" packadd! termdebug
	" packadd! matchit
else
endif
" }}}
" maps {{{

" let scroll=8
 "map <Space> 8<C-E>
" map <S-Space> 8<C-Y>
" imap <C-Space> 

nmap q <Nop>
nmap Q <Nop>
nnoremap qq :Lexplore<CR>
nnoremap ZQ :q!<CR>
inoremap jk <Esc>
nnoremap <silent> <leader>Q :%bd\|e#<cr>
nnoremap <silent> <leader>q :bd!<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>
nnoremap /, :execute 'terminal lf ' .. expand("%:h")<CR>
nnoremap <F5> :wall\|source $XDG_CONFIG_HOME/vim/shared.vim<CR>
imap <F5> <C-O><F5>

nmap hg zc

" focus {{{
nnoremap <silent> ]= :tabnext<CR>
nnoremap <silent> [- :tabprevious<CR>
nnoremap <silent> ]] :bnext<CR>
nnoremap <silent> [[ :bprevious<CR>
tnoremap <silent> ]] <C-\><C-N>:bnext<CR>
tnoremap <silent> [[ <C-\><C-N>:bprevious<CR>
nnoremap <silent> [<BS> :b#<CR>
nnoremap <silent> ]<BS> :b#<CR>
nnoremap <silent> ]\ :wincmd w<CR>
nnoremap <silent> [' :wincmd p<CR>
nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>
" }}}

" shiftround {{{
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
" }}}

" }}}
" switch {{{
let g:switch_mapping = ''
let g:switch_custom_definitions =
\ [
	\   { '\<\([invoxtcl]\?\)noremap\>': '\1map'},
	\   { '\<\([invoxtcl]\?\)map\>': '\1noremap'},
	\   { '\v^(\s*[*+-] )?\[ \]': '\1[x]',
	\     '\v^(\s*[*+-] )?\[x\]': '\1[-]',
	\     '\v^(\s*[*+-] )?\[-\]': '\1[ ]',
	\   },
	\   { '\v^(\s*\d+\. )?\[ \]': '\1[x]',
	\     '\v^(\s*\d+\. )?\[x\]': '\1[-]',
	\     '\v^(\s*\d+\. )?\[-\]': '\1[ ]',
	\   },
	\   ['left', 'right', 'middle'],
	\   ['yes', 'no'],
	\   ['on', 'off'],
	\   ['default', 'tabbed', 'stacking'],
	\   ['foldenable', 'nofoldenable'],
	\   ['true', 'false'],
	\   ['horizontal', 'vertical'],
	\   ['top', 'bottom'],
	\   ['hide', 'show'],
	\   ['enable', 'disable'],
	\   ['firefox', 'chromium-browser'],
	\   ['foo', 'bar', 'baz'],
	\   ['red', 'green', 'blue']
\ ]
nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
nmap gs <Plug>(SwitchInLine)

function! SwitchLine(cnt)
    let tick = b:changedtick
    let start = getcurpos()
    for n in range(a:cnt)
        Switch
    endfor
    if b:changedtick != tick
        return
    endif
    while v:true
        let pos = getcurpos()
        normal! w
        if pos[1] != getcurpos()[1] || pos == getcurpos()
            break
        endif
        for n in range(a:cnt)
            Switch
        endfor
        if b:changedtick != tick
            return
        endif
    endwhile
    call setpos('.', start)
endfun
" }}}
" }}}
