" set lisp
"set breakindent
"set breakindentopt=sbr
"set autoindent
"set smartindent
"set shiftwidth=2
"set tabstop=4
"set softtabstop=2
"set paste
"set cursorbind
" cpoptions=BceFsz 
set cpoptions+=ILq




if !has('gui_running') | set t_Co=256 guioptions-=e |endif
if has('nvim') | let g:self='nvim' | else | let g:self='vim' | endif  
execute "set undodir=".$XDG_STATE_HOME."/". g:self . "/undo"
call mkdir(&undodir, "p", 0700)
let g:session_dir=$XDG_STATE_HOME."/". g:self."/sessions/"
call mkdir(g:session_dir, "p", 0700)
let g:session_file=g:session_dir . substitute(getcwd(), "/","+", "g")
set sessionoptions=buffers,curdir,folds,help,tabpages,options,localoptions
augroup session
	autocmd!
	" autocmd VimEnter * if filereadable( g:session_file) | exe 'source ' . g:session_file | endif
	" autocmd VimLeave,FocusLost * silent exe 'mksession! ' . g:session_file
augroup	END
augroup files
	autocmd!
	" autocmd BufRead * if &filetype == "" | setlocal ft=text | endif
	autocmd FileType * autocmd TextChanged,InsertLeave <buffer> if empty(&buftype) && &readonly == 0 | silent write | endif

	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd BufWritePost *kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
	"autocmd VimResized * wincmd =
	" autocmd BufLeave,FocusLost * silent! wal
	" autocmd CmdlineChanged [:\/\?] call wildtrigger()
augroup END

command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
	\ | diffthis | wincmd p | diffthis

syntax on
filetype plugin indent on

set termguicolors
set showtabline=2
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

set wildmode=noselect:lastused,full
set wildoptions=pum
set wildignorecase
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



let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let g:sqlite_clib_path = $SQLITE_CLIB_PATH
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'mix'
colorscheme gruvbox-material
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }


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


function! SpawnBufferLine()
  let s = ''
  " Making a tab list on the right side
  for i in range(1, tabpagenr('$'))  " Loop through the number of tabs
    let s .= (i == tabpagenr()) ? ('%#TabLineSel#') : ('%#TabLine#')
    let s .= '%' . i . 'T '  " set the tab page number (for mouse clicks)
    let s .= i . ' '          " set page number string
  endfor
  let s .= '%#TabLineFill#%T'  " Reset highlight
  if tabpagenr('$') > 1
    let s .= '%999X X '
  endif

  " Get the list of buffers. Use bufexists() to include hidden buffers
  let bufferNums = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  for i in bufferNums
    let s .= (i == bufnr()) ? ('%#TabLineSel#') : ('%#TabLine#')
    let s .=' ' . i . '' 
    if bufname(i) == ''
      let s .= '[No Name]'
    endif
    if getbufvar(i, "&modifiable")
      let s .= fnamemodify(bufname(i), ':t') 
      " let s .= pathshorten(bufname(i)) 
      let s .= (getbufvar(i, "&modified")) ? ('+') : ('')
    else
      let s .= fnamemodify(bufname(i), ':t') . '-'
    endif
    let s .= ' '
  endfor
  " let s .= '%#TabLineFill#%T'  " Reset highlight
  let s .= '%=' " Spacer



  return s
endfunction

set tabline=%!SpawnBufferLine()  " Assign the tabline
