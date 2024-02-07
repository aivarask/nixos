" digraph
inoremap <C-z> <C-k>
nmap k gk
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <silent> <Plug>(Save) :silent w<cr>
map <C-s> <Plug>(Save)
inoremap <C-s> <C-o><C-s>

" #alt
" <M-[integer]> ./keymaps/_.lua
" <M-e> https://github.com/windwp/nvim-autopairs#fastwrap 
" <M-s> https://github.com/AndrewRadev/switch.vim
nnoremap <silent> <Plug>(SwitchInLine) :<C-U>call SwitchLine(v:count1)<CR>
nmap <M-s> <Plug>(SwitchInLine)
imap <M-s> <C-O><M-s>
" #undo #alt
inoremap <Space> <C-G>u<Space>
inoremap <M-u> <C-O>u
inoremap <M-r> <C-O><C-r>
inoremap <M-w> <C-O>w
inoremap <M-b> <C-O>b
" #comment #alt
nmap <M-c> gc$
vmap <M-c> gc
imap <M-c> <C-O>gc$
" 
inoremap <M-a> <C-O>a
inoremap <M-A> <C-O>A

" #tab #buffer
nnoremap <M-CR> :tabnew<CR>
nnoremap <M-TAB> :tabnext<CR>
tnoremap <M-TAB> :tabnext<CR>
nnoremap <M-Del> :tabclose<CR>
nnoremap <silent> <M-q> :Bclose<CR>
nnoremap <M-Q> :Bclose!<CR>


map <M--> :wincmd <<CR>
tmap <M--> <C-\><C-n>:wincmd <<CR>
map <M-=> :wincmd ><CR>
tmap <M-=> <C-\><C-n>:wincmd ><CR>

map <M-h> :wincmd h<CR>
tmap <M-h> <C-\><C-n>:wincmd h<CR>
map <M-j> :wincmd j<CR>
tmap <M-j> <C-\><C-n>:wincmd j<CR>
map <M-k> :wincmd k<CR>
tmap <M-k> <C-\><C-n>:wincmd k<CR>
map <M-l> :wincmd l<CR>
tmap <M-l> <C-\><C-n>:wincmd l<CR>

" map <M-H> :wincmd H<CR>
" map <M-J> :wincmd J<CR>
" map <M-K> :wincmd K<CR>
" map <M-L> :wincmd L<CR>

nnoremap cp "+y
vnoremap cp "+y

" #space
nnoremap <SPACE> <Nop>
nnoremap <Space>m :messages<CR>
map <silent> <TAB> :bn<CR>
map <silent> <S-TAB> :bp<CR>

map <silent> [q :cp<CR>
map <silent> ]q :cn<CR>

map <silent> <leader>. :vertical resize +5<CR>
map <silent> <leader>, :vertical resize -5<CR>


nmap <leader>q :quitall<CR>

if !exists('*SaveExec')
  function! SaveExec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif
    return
  endfunction
endif
nmap <leader><leader>a :call SaveExec()<CR>

function! Ctoggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction
nnoremap tq :call Ctoggle()<CR>

