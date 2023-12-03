set autoindent
set background=dark
set cmdheight=2
set completeopt=menu,menuone,noselect
set cursorline
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set foldmethod=expr
set foldnestmax=5
set hidden
set ignorecase 
" set iskeyword+=$
set laststatus=2
set lazyredraw
set modeline 
set mouse=a 
set noshowmode
set number
set scrolloff=4
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
set titlestring=%{getcwd()}\ \ \ %{expand('%')}
set updatetime=1500

hi! link netrwMarkFile Search
let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:bclose_no_plugin_maps=1
let g:floaterm_autoclose = 2
let g:floaterm_height = 0.7
let g:floaterm_width = 0.8
let g:floaterm_wintype = 'float'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8  }  }
let g:fzf_preview_window = ['hidden,right,50%,<70(up,60%)', 'ctrl-/']
let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
let g:interestingWordsDefaultMappings = 0
let g:lf_map_keys = 0
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
  if has('termguicolors')
    set termguicolors
    let g:gruvbox_material_background = 'medium'
    let g:gruvbox_material_foreground = 'mix'
  endif
  colorscheme gruvbox-material
else
  colorscheme gruvbox-material
  nnoremap <F12> :FloatermToggle<CR>
  tnoremap <F12> <C-W>:FloatermToggle<CR>
  let g:AutoPairsFlyMode = 1
  let g:AutoPairsShortcutBackInsert = '<C-b>'
endif
if !has('gui_running')
  set t_Co=256
  set guioptions-=e
endif
