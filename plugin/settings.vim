set autoindent
set cmdheight=4
set completeopt=menu,menuone,noselect
set cursorline
set expandtab
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set foldlevelstart=2
" set foldlevel=3
" set foldlevel=99
" set foldnestmax=5
set hidden
set ignorecase 
set laststatus=2
set lazyredraw
set modeline 
set mouse=a 
set noshowmode
set number
set shiftwidth=2
set showtabline=2
set signcolumn=yes
set smartindent
set splitbelow 
set splitright
set statusline+=%F
set tabstop=2
set timeoutlen=200
set title 
" set titlestring=%{expand('%:h')}
" set titlestring=%{getcwd()}\ \ \ %{expand('%')}
set titlestring=%{expand('%:h')}\ %{getcwd()}
set updatetime=1500

hi! link netrwMarkFile Search
let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_winsize = 30

if has('nvim')
  set undodir=$HOME/.vim/undo
  set undofile 
  set noswapfile
endif
if !has('gui_running')
  set t_Co=256
  set guioptions-=e
endif
