filetype plugin indent on
set termguicolors
set title titlestring=%{expand('%')}\ %{hostname()}
set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos,terminal
set completeopt=menu,menuone,noselect
set cursorline mouse=a
set hidden
set ignorecase
set lazyredraw
set modeline
set noshowmode
set signcolumn=yes number
set splitright splitbelow
set showtabline=2 statusline+=%F 
set cmdheight=3
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set nolisp
set noswapfile
set background=dark
set undofile
set nofoldenable
set scrolloff=15
set autowriteall
set updatetime=250
set timeoutlen=600

let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:bclose_no_plugin_maps=1
let g:lf_map_keys = 0

map - :cd ..<CR> 
nnoremap <silent> <Plug>(Save) :silent write<cr>
map <C-s> <Plug>(Save)
" inoremap <Space> <C-G>u<Space>
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
nnoremap <silent> <leader>a :call SaveExec()<CR>
nnoremap <silent> <leader>d :edit /etc/nixos/doc/nixos.txt<CR>
nnoremap <silent> <leader>m :messages<CR>
nnoremap <silent> <leader>L :LazyGit<CR>

if !has('gui_running')
	set t_Co=256
	set guioptions-=e
endif

if !has('nvim')
	aug VimOnly
		au!
		autocmd VimLeavePre,QuitPre * mksession!
	aug END
	if !isdirectory($HOME.'/.vim')
		call mkdir($HOME.'/.vim', '', 0770)
		if !isdirectory($HOME.'/.vim/undo')
			call mkdir($HOME.'/.vim/undo', '', 0700)
		endif
	endif
	set showcmd
	set undodir=~/.vim/undo
	set foldmethod=indent
	let g:AutoPairsFlyMode = 0
	let g:AutoPairsShortcutBackInsert = ''
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail'
	let g:airline#extensions#whitespace#enabled = 0
	let g:airline_powerline_fonts = 1
	let g:webdevicons_enable_nerdtree = 0
	let g:which_key_vertical = 1
	let g:NERDTreeMapPreview = '<TAB>'
	nnoremap qq <cmd>NERDTreeToggle<CR>
	nnoremap <leader>c :Commands<CR>
	nnoremap <leader>f :Files<CR>
	nnoremap <leader>g :Rg<CR>
	nnoremap <leader>h :Helptags<CR>
	nnoremap <leader>k :Maps<CR>
	nnoremap <silent> <leader> :<C-U>WhichKey '\'<CR>
	nnoremap <silent> ] :<C-U>WhichKey ']'<CR>

	inoremap <Esc>h <C-O>h
	inoremap <Esc>j <C-O>j
	inoremap <Esc>k <C-O>k
	inoremap <Esc>l <C-O>l

	nnoremap <Esc>h :wincmd h<CR>
	nnoremap <Esc>j :wincmd j<CR>
	nnoremap <Esc>l :wincmd l<CR>
	
	cnoremap <nowait> <Esc>h <Left>
	cnoremap <nowait> <Esc>l <Right>
else
	set undodir=$XDG_STATE_HOME/nvim/undo
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
	nnoremap <leader>c :Telescope commands<CR>
	nnoremap <leader>f :Telescope find_files<CR>
	nnoremap <leader>g :Telescope live_grep<CR>
	nnoremap <leader>h :Telescope help_tags<CR>
	nnoremap <leader>k :Telescope keymaps<CR>

	inoremap <M-h> <C-O>h
	inoremap <M-j> <C-O>j
	inoremap <M-k> <C-O>k
	inoremap <M-l> <C-O>l

	nnoremap <M-h> :wincmd h<CR>
	nnoremap <M-j> :wincmd j<CR>
	nnoremap <M-l> :wincmd l<CR>
	tnoremap <M-h> <C-\><C-n>:wincmd h<CR>
	tnoremap <M-j> <C-\><C-n>:wincmd j<CR>
	tnoremap <M-k> <C-\><C-n>:wincmd k<CR>
	tnoremap <M-l> <C-\><C-n>:wincmd l<CR>
	
	cnoremap <M-h> <Left>
	cnoremap <M-l> <Right>
	
	nnoremap <M-J> :m .+1<CR>==
	nnoremap <M-K> :m .-2<CR>==
	inoremap <M-J> <Esc>:m .+1<CR>==gi
	inoremap <M-K> <Esc>:m .-2<CR>==gi
	vnoremap <M-J> :m '>+1<CR>gv=gv
	vnoremap <M-K> :m '<-2<CR>gv=gv
endif

" CTRL-W    delete word to the left of cursor
" CTRL-O D  delete everything to the right of cursor
" CTRL-U    delete everything to the left of cursor
" CTRL-H    backspace/delete
" CTRL-J    insert newline (easier than reaching for the return key)
" CTRL-T    indent current line
" CTRL-D    un-indent current line

" map <M--> :wincmd <<CR>
" tmap <M--> <C-\><C-n>:wincmd <<CR>
" map <M-=> :wincmd ><CR>
" tmap <M-=> <C-\><C-n>:wincmd ><CR>
