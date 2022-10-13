" let &viminfofile = expand('~/.local/share/nvim/shada/main.shada')
" let &viminfofile = &shadafile

set title
set ignorecase modeline number
set hidden
set mouse=a noshowmode showcmd cmdheight=4 signcolumn=yes cursorline showtabline=2
set laststatus=2
set statusline+=%F
set scrolloff=4
set splitbelow splitright
set noautoindent
set shiftwidth=2
set tabstop=2
set expandtab
set shellcmdflag=-ic
set foldlevel=4
" set foldmethod=expr
set foldmethod=manual
set foldexpr=nvim_treesitter#foldexpr()
set updatetime=300
" set lcs+=space:·
" set list
" set nohlsearch
" set copyindent
" set shellcmdflag=-ci

" set completeopt=menuone,noselect,preview
set completeopt=menu,menuone,noselect

set lazyredraw

let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
hi! link netrwMarkFile Search

"cursors by vim modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

function! FloatermResize() abort
  let g:floaterm_width = get(g:, 'floaterm_width', &columns/2)
  let g:floaterm_height = get(g:, 'floaterm_height', winheight(0)/2)
endfunction

command Resize :let g:floaterm_width=0.8

augroup Settings
  autocmd!
  " autocmd VimResized * FloatermResize
augroup END

let g:floaterm_wintype = 'float'
let g:floaterm_autoclose = 2
let g:floaterm_width = 0.8
let g:floaterm_height = 0.7


if !has('gui_running')
  set t_Co=256
  set guioptions-=e
endif

" call lightline#disable()
if has ('nvim')
  set undodir=$HOME/.vim/undo
  set undofile 
else
  let g:AutoPairsFlyMode = 1
  let g:AutoPairsShortcutBackInsert = '<C-b>'

endif
