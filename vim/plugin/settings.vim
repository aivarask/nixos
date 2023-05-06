set timeout
set timeoutlen=200
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
" set foldlevel=2
" set foldnestmax=10
set smartindent
set title titlelen=70
set titlestring=%{getcwd()}
set ignorecase modeline number
set hidden
set mouse=a noshowmode showcmd cmdheight=2
set cursorline showtabline=2
set laststatus=2
set statusline+=%F
set scrolloff=4
set splitbelow splitright
set noautoindent
set shiftwidth=2
set tabstop=2
set expandtab
set updatetime=1500
set completeopt=menu,menuone,noselect
set lazyredraw
set iskeyword+=$
set signcolumn=yes

set background=dark
if has('nvim')
  if has('termguicolors')
    set termguicolors
    let g:gruvbox_material_background = 'medium'
    let g:gruvbox_material_foreground = 'mix'
  endif
  colorscheme gruvbox-material
else
  colorscheme gruvbox-material
endif


let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
let g:lf_map_keys = 0
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

let g:floaterm_wintype = 'float'
let g:floaterm_autoclose = 2
let g:floaterm_width = 0.8
let g:floaterm_height = 0.7

" https://github.com/junegunn/fzf.vim#preview-window
let g:fzf_preview_window = ['hidden,right,50%,<70(up,60%)', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8  }  }

if !has('gui_running')
  set t_Co=256
  set guioptions-=e
endif

if has ('nvim')
  set undodir=$HOME/.vim/undo
  set undofile 
  set noswapfile
else
  let g:AutoPairsFlyMode = 1
  let g:AutoPairsShortcutBackInsert = '<C-b>'
endif

