" dependencies {{{
set verbose=0
source /etc/nixos/vimfunc.vim
source /etc/nixos/vimpersist.vim
packadd cfilter
let g:loaded_sensible=1
let g:loaded_matchit=1
let g:loaded_EditorConfig=1
let g:no_vim_maps=1
" }}}
set sessionoptions=buffers,curdir,folds,help,tabpages,terminal
if !has('nvim') && 0 | set sessionoptions+=localoptions| endif
set bufhidden=delete

runtime ftplugin/man.vim
aug vimrc
	au!
	au VimResized * wincmd =
	au VimEnter * nested
				\ if !argc() && empty(v:this_session) && !&modified|
				\   if filereadable('Session.vim')|
				\     source Session.vim|
				\	Runtime|
				\   else|
				\     Obsession|
				\   endif|
				\ endif
	" au BufEnter * if &buftype == 'help' | filetype detect | endif
	" au FileType help | set buftype= | exe winnr('#').'quit'
	" au FileType * autocmd BufEnter <buffer>  let b:did_add_maps=1
	au FileType help,netrw map <buffer> [[ :bprevious<CR>
	au FileType help,netrw map <buffer> ]] :bnext<CR>
	au filetype netrw map <buffer> D <Nop>
	au filetype netrw map <buffer> a <Nop>
	au QuickFixCmdPost [^l]* cwindow
	au QuickFixCmdPost l*    lwindow
	au VimEnter        *     cwindow
	au CmdlineEnter /,\? set hlsearch
	au CmdlineLeave /,\? set nohlsearch
	" au CursorHold * :exec 'match Search /\V\<' . expand('<cword>') . '\>/'
	if !has('nvim') 
		au TerminalOpen,WinEnter "term://*" startinsert  
	endif
	" au CmdlineChanged * silent call Exec('PP complete_info()')
	" echom strftime("%H:%M:%S") 'update'
	au FocusLost,InsertLeave,TextChanged * if empty(&buftype) && &readonly == 0 && !empty(&filetype) | update  | endif
	au FocusGained,CursorHold,CursorHoldI * if empty(&buftype) | checktime | endif
	au BufWritePost *kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
	au BufWritePost *kitty/quick_access_terminal.conf :silent !kill -SIGUSR1 $(pgrep kitty)
	" au BufHidden,BufLeave * if expand("<afile>") == "" && &modified == 0 && &filetype != "qf" | silent! bd | endif
	au CmdlineChanged [:\/\?] call wildtrigger()
	" au CmdlineChanged * call Log('cmd')
	" au CompleteChanged * call CompleteInfo()
	" au CompleteChanged * call Log('comp')
aug END


" lsp {{{
let g:lsp_use_native_client = 1
let g:lsp_fold_enabled = 0
if (executable('nixd'))
	au User lsp_setup call lsp#register_server({
				\ 'name': 'nixd',
				\ 'cmd': {server_info->['nixd']},
				\ 'allowlist': ['nix'],
				\ 'config': {},
				\ 'workspace_config': {'param': {'enabled': v:true}},
				\ 'languageId': {server_info->'nix'},
				\ })
endif
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gt <plug>(lsp-type-definition)
	nmap <buffer> grap <plug>(lsp-code-action-preview)
	nmap <buffer> gra <plug>(lsp-code-action)
	nmap <buffer> grn <plug>(lsp-rename)
	nmap <buffer> [d <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]d <plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
	nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

	let g:lsp_format_sync_timeout = 1000
	autocmd! BufWritePre *.nix,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" }}}

function! Log(...) abort 
	redir! >vim.log
	silent echo strftime("%H:%M:%S")
	silent echo $"Hello, {a:1}!"
	redir END
endfunction

function! CompleteInfo()
	let item = v:event.completed_item
	let comp_info = complete_info()
	let id = popup_findinfo()
	redir! >vim.log
	silent PP comp_info
	silent PP item
	silent echo strftime("%H:%M:%S")
	silent echo $"info {id}"
	redir END
	if id
		call popup_settext(id, 'async info: ' .. item.info)
		call popup_show(id)
	endif
endfunction

function! Complete(findstart, base)
	let months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'] 
	let compitems = [{'word': 'one', 'abbr': 'on', 'menu':'on_menu', 'info':'on_info', 'kind': 'A'},
				\{'word': 'two', 'abbr': 'tw', 'menu':'tw_menu', 'info':'tw_info', 'kind': 'Z'}]
	call complete(col('.'), compitems)
	let files = glob("**", v:false, v:true)
	return a:cmdarg == '' ? files : matchfuzzy(files, a:cmdarg)
endfunction

" completion {{{
set path=.,,**
set wildignorecase
set wildmode=noselect:lastused,full
set wildoptions=pum
set wildcharm=<C-Z>
set autocomplete
set autocompletetimeout=100
set autocompletedelay=300
set complete^=o
" set complete=.
set completetimeout=100
set completeopt=menu,menuone,noselect
set completeopt+=popup
set completeopt+=preview
" set completeopt+=fuzzy
" set completeopt+=popuphidden
" set omnifunc=
" set complete^=F
" let &completefunc=Complete
" set completefunc=Complete
"}}}



" keymaps {{{
let no_plugin_maps = 1

" nnoremap <buffer> ,<CR> :silent %y\|@b<CR>
let @a = "ggo/* Comment header */\n*/\n"
let @b = "ggo Comment header <Esc>gcc"
nmap q <Nop>
nmap Q <Nop>
nmap <BS> X
nnoremap <expr> <F2> Woo() 
inoremap <F4> <C-R>=Complete()<CR>
nnoremap <F5> :silent update\|source vimrc\|silent Runtime<CR> | imap <F5> <C-O><F5>
nnoremap <F6> <cmd>Obsession!<CR> | imap <F6> <C-O><F6> 
nnoremap <silent> qq :Lexplore<CR>
nnoremap <silent> ZQ <cmd>quitall!<cr>
nnoremap <silent> \Q <cmd>%bd\|e#<cr>
nnoremap <silent> \q <cmd>bd!<CR>
nnoremap <silent> \a <cmd>call SourceLuafile()<CR>
nnoremap <silent> \h <cmd>set hlsearch!<cr>
nmap gs <Plug>(SwitchInLine)
nnoremap /<CR> :execute 'terminal++close lf ' .. expand("%:h")<CR>
nmap /. :find<space>
nmap // :Grep<space>

nmap <silent> ` :Term<CR>
nmap <silent> <C-`> :Term lazygit<CR>
tmap <silent> ` <C-\><C-N><C-W>:Term<CR>
tmap <Esc> <C-\><C-N>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" }}}
" move/lines {{{
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>
cnoremap <nowait> <Esc>h <Left>
cnoremap <nowait> <Esc>l <Right>
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
" buf/win/tab next/prev  {{{
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>
nnoremap <M-n> :execute ":buffer ".(bufnr("%") + 1)<CR>
nnoremap <M-p> :execute ":buffer ".(bufnr("%") - 1)<CR>
nnoremap <silent> ]= :tabnext<CR>
nnoremap <silent> [- :tabprevious<CR>
nnoremap <silent> ]] :bnext<CR>
nnoremap <silent> [[ :bprevious<CR>
tnoremap <silent> ]] <C-\><C-N>:bnext<CR>
tnoremap <silent> [[ <C-\><C-N>:bprevious<CR>
nnoremap <silent> ]\ :wincmd w<CR>
nnoremap <silent> [' :wincmd p<CR>
" }}}

" terminal {{{
set termguicolors
if !has('nvim') | set term=kitty | endif
if &term =~ '256color' | set t_ut= | endif
if !has('gui_running') | set t_Co=256 guioptions-=e |endif
let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_kb = "^V<BS>"
" fixdel
" }}}

" settings {{{
syntax on
filetype indent plugin on
set history=50
set shortmess=oOtTWAIcCF
set hidden
set mouse=a
set mousefocus
set lazyredraw
set modeline
set splitkeep=topline
set splitbelow
set timeoutlen=500
set conceallevel=2
set clipboard=unnamedplus
set shiftround
set gdefault
set ignorecase
set smartcase
set whichwrap+=<,>,[,]
set previewheight=32
set noswapfile
set updatetime=400
set autoread
set breakindent
set wrap
set sidescrolloff=8
set scrolloff=16
set cmdheight=4
let g:sqlite_clib_path = $SQLITE_CLIB_PATH
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'mix'
set background=dark
colorscheme gruvbox-material
" }}}

" search grep find fold {{{
" set grepformat="%f:%l:%m,%f:%l%m,%f  %l%m"
set wildignore+=.git/
" set wildignore=
set shortmess+=Ss
" set hlsearch
set incsearch
set grepprg=rg\ --vimgrep\ --smart-case\ --follow	
set findfunc=FindFunc
set foldmethod=marker
set foldtext=FoldText()
" }}}

" title/tabline/statusline {{{
" let &titleold=getcwd()
set title 
set titlestring=%{Progname()}\ %{getcwd()}\ %f\ 
set showtabline=2
set tabline=%!TabLine()
set showcmdloc=statusline
set statusline=%#Search#%h%w%q\ %n\ %.24f\ %l\/%L\ %m%r%y\ %{ObsessionStatus()}\ %S
set laststatus=2
set showmode
" }}}

" netrw {{{
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_winsize=20
let g:netrw_wiw=4
let g:netrw_sizestyle="H"
let g:netrw_sort_options="i"
let g:netrw_mousemaps=0
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
" }}}


