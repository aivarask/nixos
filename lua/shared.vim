let g:session_dir=$XDG_DATA_HOME."/vim/session/"
call mkdir(g:session_dir, "p", 0700)
let g:session_file=g:session_dir . substitute(getcwd(), "/","+", "g")
set sessionoptions=buffers,curdir,folds,help,tabpages,skiprtp

command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
	\ | diffthis | wincmd p | diffthis


if has('nvim') | let g:self='nvim' | else | let g:self='vim' | endif  

augroup session
	au!
	autocmd VimEnter * if filereadable( g:session_file) | exe 'source ' . g:session_file | endif
	autocmd VimLeave,FocusLost * silent exe 'mksession! ' . g:session_file
	autocmd BufHidden * execute 'echo ' .. expand("<abuf>")
augroup END

augroup minimal
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd VimResized * wincmd =
	autocmd BufLeave,FocusLost * silent! wal
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
set titlestring=%{g:self}\ \ %{getcwd()}
set showtabline=2
" set tabline=%n
set statusline=%n\ %f:%l:%c\ %L\ %m\ %r\ %y\ %q\ 
set shortmess+=F
set hidden

set completeopt=menu,menuone,noselect
set cursorline
set mouse=a
set mousefocus
set lazyredraw
set modeline
set noshowmode
set splitkeep=topline
set splitbelow
set nowrap
" set showbreak=↪>\
set noswapfile
set autowriteall
set background=dark
set undofile
set updatetime=400
set timeoutlen=500
set conceallevel=2
set clipboard=unnamedplus
set scrolloff=8
set cmdheight=2
set lisp

"https://vi.stackexchange.com/questions/43386/how-to-force-vim-to-delete-all-the-no-name-buffers
set shiftround
set gdefault
set ignorecase
set smartcase
set wildcharm=<C-Z>
"cnoremap ss so /etc/nixos/lua/*.vim<C-Z>
command! SC vnew
        \ | setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
        \ | nnoremap <buffer> ,s :silent %source<CR>
"nnoremap <buffer> ,<CR> :silent %y\|@b<CR>


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

