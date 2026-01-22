syntax on
filetype plugin indent on
set termguicolors
set title titlestring=\ %{bufnr('%')}\ %{expand('%')}\ %{hostname()}
set completeopt=menu,menuone,noselect
"set wildmenu
"set wildmode=noselect

set cursorline 
set mouse=a
set mousefocus
set hidden
set ignorecase
set lazyredraw
set modeline
set noshowmode
set signcolumn=yes number relativenumber
set splitright splitbelow
set showtabline=2 statusline+=%F
set nowrap
set breakindent
set breakindentopt=sbr
" set showbreak=↪>\

set noswapfile
set background=dark
set undofile
set autowriteall
set updatetime=250
set timeoutlen=600
set bufhidden=unload
"set commentstring=#\ %s
set conceallevel=2
set clipboard=unnamedplus

set tabstop=2
"set autoindent
"set smartindent
"set paste
set shiftwidth=2

autocmd CmdlineChanged [:\/\?] call wildtrigger()
set wildmode=noselect:lastused,full
set wildoptions=pum
set wildignorecase

let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = [ 
			\ "TextChanged"]			
" "InsertLeave"

let g:bclose_no_plugin_maps=1
let g:lf_map_keys = 0
let g:interestingWordsDefaultMappings=0
let g:vim_markdown_no_default_key_mappings = 1
let g:sqlite_clib_path = $SQLITE_CLIB_PATH

map q <nop>
map Q <nop>
nmap - :cd ..<CR>

nnoremap <silent> <Plug>(Save) :silent write<cr>
" inoremap <Space> <C-G>u<Space>

nmap <silent> <Tab>l :bnext<cr>
nmap <silent> <Tab><Tab> :bnext<cr>
nmap <silent> <Tab><S-Tab> :bprevious<cr>
nmap <silent> <S-Tab><S-Tab> :bprevious<cr>
nmap <silent> <Tab>h :bprevious<cr>
nmap ]] :bnext<cr>
nmap [[ :bprevious<cr>
map <silent> ]b :bnext<CR>
map <silent> [b :bprevious<CR>
nnoremap <leader><tab> :bnext<cr>
nnoremap <leader><space> :b#<cr>
map [c :cprevious<CR>
map ]c :cnext<CR>
map ]C :call Ctoggle()<CR>
map [C :call Ctoggle()<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>
map ]T :tabclose<CR>
map [T :tabclose<CR>
nmap <C-k> [%
nnoremap <silent> <leader>q :Bclose<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>
nnoremap <silent> <leader>l :LazyGit<CR>
"noremap <C-S-,> :left<CR>
nnoremap ?a :edit ~/.alias<CR>
nnoremap ?f :edit /etc/nixos/flake.nix<CR>
nnoremap ?z :edit $ZDOTDIR/.zshrc_<CR>
nnoremap ?b :edit ~/.config/sway/bindings<CR>

if !has('gui_running')
	set t_Co=256
	set guioptions-=e
endif

if has('nvim')
	set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos
	set nofoldenable
	" set foldmethod=expr
	"set foldexpr=nvim_treesitter#foldexpr()
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
	nmap <leader>N :Neotest
	nnoremap <leader>n :Neotest summary toggle<CR>

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

	nnoremap <M-J> :m .+1<CR>==
	nnoremap <M-K> :m .-2<CR>==
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

	" map <M--> :wincmd <<CR>
	" tmap <M--> <C-\><C-n>:wincmd <<CR>
	" map <M-=> :wincmd ><CR>
	" tmap <M-=> <C-\><C-n>:wincmd ><CR>
