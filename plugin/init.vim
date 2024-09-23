if !exists('*SaveExec')
	function! SaveExec() abort
		if &filetype ==?'vim'
			" :%s/\s\+$//e
			:silent! write
			:source %
		elseif &filetype ==?'lua'
			:silent! write
			:luafile %
		endif
		return
	endfunction
endif

function! Ctoggle()
	if empty(filter(getwininfo(), 'v:val.quickfix'))
		copen
	else
		cclose
	endif
endfunction

function! Demo()
	" https://vim.fandom.com/wiki/User_input_from_a_script
	let curline = getline('.')
	call inputsave()
	let name = input('Enter name: ')
	call inputrestore()
	call setline('.', curline . ' ' . name)
endfunction

if !has('gui_running')
	set t_Co=256
	set guioptions-=e
endif

let &packpath.=',/etc/nixos'
filetype plugin indent on
set title titlestring=%{expand('%')}\ %{hostname()}
set completeopt=menu,menuone,noselect
set cursorline mouse=a
set hidden
set ignorecase
set lazyredraw
set modeline
set noshowmode
set signcolumn=yes number
set splitright splitbelow
set updatetime=1500 timeoutlen=600
set showtabline=2 statusline+=%F cmdheight=3
set autoindent
set smartindent
set tabstop=2
set shiftwidth=0
set nolisp
set noswapfile
set termguicolors
set background=dark
set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos,terminal

let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:bclose_no_plugin_maps=1
let g:lf_map_keys = 0

aug Common
	au!
	autocmd BufEnter * checktime
	autocmd VimResized * wincmd =
		autocmd FileType * autocmd TextChanged,CursorHoldI,InsertLeave <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
aug END

nnoremap <silent> <Plug>(Save) :silent write<cr>
map <C-s> <Plug>(Save)

inoremap <Space> <C-G>u<Space>
map <silent> <TAB> :bn<CR>
map <silent> <S-TAB> :bp<CR>
map [c :cprevious<CR>
map ]c :cnext<CR>
map ]C :call Ctoggle()<CR>
map [C :call Ctoggle()<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>
map ]T :tabclose<CR>
map [T :tabclose<CR>
nnoremap <silent> <leader>q :Bclose<CR>
nnoremap <silent> <leader>Q :quitall<CR>
nnoremap <leader>a :call SaveExec()<CR>
nnoremap <leader>d :edit /etc/nixos/doc/nixos.txt<CR>
nnoremap <F2> @:<CR>
if !has('nvim')
	aug VimOnly
		au!
		autocmd VimLeavePre,QuitPre * mksession!
	aug END
	set showcmd
	if !isdirectory($HOME.'/.vim')
		call mkdir($HOME.'/.vim', '', 0770)
	endif
	if !isdirectory($HOME.'/.vim/undo')
		call mkdir($HOME.'/.vim/undo', '', 0700)
	endif
	set undodir=~/.vim/undo
	set undofile
	let g:AutoPairsFlyMode = 0
	let g:AutoPairsShortcutBackInsert = ''
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail'
	let g:airline#extensions#whitespace#enabled = 0
	let g:webdevicons_enable_nerdtree = 0
	let g:which_key_vertical = 1
	let g:NERDTreeMapPreview = '<TAB>'
	nnoremap qq <cmd>NERDTreeToggle<CR>
	nnoremap <leader>f :Files<CR>
	nnoremap <leader>g :Rg<CR>
	nnoremap <leader>h :Helptags<CR>
	nnoremap <leader>k :Maps<CR>
	nnoremap <silent> <leader> :<c-u>WhichKey '\'<CR>
	" nnoremap <silent> [ :<C-u>WhichKey '['<CR>
	" nnoremap <silent> ] :<C-u>WhichKey ']'<CR>
	set foldmethod=indent
	set nofoldenable
else
	set undodir=$XDG_STATE_HOME/nvim/undo
	set undofile
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
	set nofoldenable
	nnoremap <leader>f :Telescope find_files<CR>
	nnoremap <leader>g :Telescope live_grep<CR>
	nnoremap <leader>h :Telescope help_tags<CR>
	nnoremap <leader>k :Telescope keymaps<CR>
endif

" CTRL-W    delete word to the left of cursor
" CTRL-O D  delete everything to the right of cursor
" CTRL-U    delete everything to the left of cursor
" CTRL-H    backspace/delete
" CTRL-J    insert newline (easier than reaching for the return key)
" CTRL-T    indent current line
" CTRL-D    un-indent current line

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

inoremap <M-h> <C-o>h
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
inoremap <M-l> <C-o>l
cnoremap <M-H> <Left>
cnoremap <M-J> <Down>
cnoremap <M-K> <Up>
cnoremap <M-L> <Right>

map <M-h> :wincmd h<CR>
tmap <M-h> <C-\><C-n>:wincmd h<CR>
map <M-j> :wincmd j<CR>
tmap <M-j> <C-\><C-n>:wincmd j<CR>
map <M-k> :wincmd k<CR>
tmap <M-k> <C-\><C-n>:wincmd k<CR>
map <M-l> :wincmd l<CR>
tmap <M-l> <C-\><C-n>:wincmd l<CR>

map <M--> :wincmd <<CR>
tmap <M--> <C-\><C-n>:wincmd <<CR>
map <M-=> :wincmd ><CR>
tmap <M-=> <C-\><C-n>:wincmd ><CR>

" hi! link netrwMarkFile Search
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
" let g:netrw_banner = 0
" let g:netrw_keepdir = 0
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_localcopydircmd = 'cp -r'
" let g:netrw_winsize = 30

