augroup minimal
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd VimResized * wincmd =
	autocmd BufLeave,FocusLost * silent! wal
	" autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif
	" autocmd CmdlineChanged [:\/\?] call wildtrigger()
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
set title
set titlestring=\ %{expand('%:p')}\
set completeopt=menu,menuone,noselect
set cursorline
set mouse=a
set mousefocus
set hidden
set ignorecase
set lazyredraw
set modeline
set noshowmode
set number
set norelativenumber
set splitkeep=topline
set splitbelow
set showtabline=2
set statusline+=%F
set nowrap
" set showbreak=↪>\
set noswapfile
set autowriteall
set background=dark
set undofile
set updatetime=400
set timeoutlen=500
set bufhidden=unload
set conceallevel=2
set clipboard=unnamedplus
set scrolloff=8
set cmdheight=2
set lisp

"set breakindent
"set breakindentopt=sbr
"set autoindent
"set smartindent
"set shiftwidth=2
"set tabstop=4
"set softtabstop=2
"set paste
"set cpoptions+=ILq
"set cursorbind

let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:sqlite_clib_path = $SQLITE_CLIB_PATH
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:auto_save = 1
let g:auto_save_no_updatetime = 0
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
" let g:auto_save_events = ["InsertLeave"]
" let g:auto_save_write_all_buffers = 1


"let g:auto_save_postsave_hook = 'TagsGenerate'
" let g:auto_save_presave_hook = 'call LspFormat()'
" Example hook from vim-auto-save-git-hook plugin
function! LspFormat()
  if has('nvim')
    :lua if vim.lsp.buf_is_attached() then vim.lsp.buf.format() end
    let g:auto_save_abort = 0
  else
    " let g:auto_save_abort = 0
  endif
endfunction

