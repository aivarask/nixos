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

let g:floaterm_wintype = 'vsplit'
let g:floaterm_autoclose = 2
let g:floaterm_width = 0.5

let g:fzf_preview_window = ['up:60%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8  }  }

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
" https://github.com/itchyny/lightline.vim
" https://github.com/mengelbrecht/lightline-bufferline
" https://github.com/josa42/nvim-lightline-lsp/
" let g:lightline.enable = {
" 		    \ 'statusline': 0,
" 		    \ 'tabline': 0
" 		    \ }

" let g:lightline = {
"   \ 'enable': 0
"   \}

" let g:lightline = {
"       \ 'colorscheme': 'one',
"       \ 'active': {
"         \   'left': [ [ 'mode', 'paste' ],
"         \             [ 'readonly', 'absolutepath', 'modified', 'helloworld' ],
"         \             [ 'lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok' ],
"         \             [ 'lsp_status']
"         \           ]
"         \ },
"         \ 'tabline': {
"           \   'left': [ ['buffers'] ],
"           \   'right': [ ['tabs', 'close'] ]
"           \ },
"           \ 'component_expand': {
"             \   'buffers': 'lightline#bufferline#buffers'
"             \ },
"             \ 'component_type': {
"               \   'buffers': 'tabsel'
"               \ }
"               \ }
" call lightline#lsp#register()

