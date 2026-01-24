augroup minimal
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd VimResized * wincmd =
		autocmd BufLeave,FocusLost * silent! wal
augroup END

augroup cmdline
	autocmd!
	autocmd CmdlineChanged [:\/\?] call wildtrigger()
augroup END
set wildmode=noselect:lastused,full
set wildoptions=pum
set wildignorecase

if !has('gui_running')
	set t_Co=256
	set guioptions-=e
endif

syntax on
filetype plugin indent on
set termguicolors
set title titlestring=\ %{bufnr('%')}\ %{expand('%')}\ %{hostname()}
set completeopt=menu,menuone,noselect
set cursorline 
set mouse=a
set mousefocus
set hidden
set ignorecase
set lazyredraw
set modeline
set noshowmode
set signcolumn=yes number relativenumber 
set splitkeep=topline
set splitbelow
set showtabline=2 statusline+=%F
set nowrap
" set showbreak=↪>\
set noswapfile
set autowriteall
set background=dark
set undofile
set updatetime=500
set timeoutlen=600
set bufhidden=unload
set conceallevel=2
set clipboard=unnamedplus
set tabstop=2
set breakindent
set breakindentopt=sbr
"set autoindent
"set smartindent
set shiftwidth=2
"set paste
"set cpoptions+=ILq
"set cursorbind

let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["TextChanged"]			
let g:bclose_no_plugin_maps=1
let g:lf_map_keys = 0
let g:interestingWordsDefaultMappings=0
let g:vim_markdown_no_default_key_mappings = 1
let g:sqlite_clib_path = $SQLITE_CLIB_PATH

