" packadd comment
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
set updatetime=1500 
set timeoutlen=500
set showtabline=2 statusline+=%F cmdheight=3
set autoindent smartindent shiftwidth=2 tabstop=2
" set lisp softtabstop=2 noexpandtab shiftround cpoptions+=I

if !has('gui_running')	
  set t_Co=256
  set guioptions-=e
endif

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

aug Other
  au!
  autocmd BufEnter * checktime
  autocmd BufEnter *svelte-kit/* set buftype=nowrite
  autocmd VimResized * wincmd =
  autocmd FileType * autocmd TextChanged,CursorHoldI,InsertLeave <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
aug END
