let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', 'pistol {}']}, <bang>0)
nmap <M-x>! :🟢 CTRL-T, CTRL-X, CTRL-V
nmap <M-x>/ :History/<cr>
nmap <M-x>: :History:<cr>
nmap <M-x>F :History<cr>
nmap <M-x>G :RG<cr>
nmap <M-x>H :Rg http<cr>
nmap <M-x>L :Locate <c-r><c-w>
nmap <M-x>M :Maps<cr>
nmap <M-x>b :Buffers<cr>
nmap <M-x>c :Commands<cr>
nmap <M-x>f :Files<cr>
nmap <M-x>g :Rg<cr>
nmap <M-x>h :Helptags<cr>
nmap <M-x>j :Jumps<cr>
nmap <M-x>l :Locate 
nmap <M-x>m :Marks<cr>
nmap <M-x>w :Rg <c-r><c-w><cr>

nnoremap <silent> <Plug>(Save) :w<cr>
map <C-s> <Plug>(Save)
inoremap <C-s> <C-o><C-s>

" #undo break undo?
inoremap <Space> <C-G>u<Space>

" nnoremap <SPACE> <Nop>
map <silent> <TAB> :bn<CR>
map <silent> <S-TAB> :bp<CR>


" CTRL-W    delete word to the left of cursor
" CTRL-O D  delete everything to the right of cursor
" CTRL-U    delete everything to the left of cursor
" CTRL-H    backspace/delete
" CTRL-J    insert newline (easier than reaching for the return key)
" CTRL-T    indent current line
" CTRL-D    un-indent current line

inoremap <M-h> <C-o>h
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
inoremap <M-l> <C-o>l
cnoremap <M-H> <Left>
cnoremap <M-J> <Down>
cnoremap <M-K> <Up>
cnoremap <M-L> <Right>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

map <M-h> :wincmd h<CR>
tmap <M-h> <C-\><C-n>:wincmd h<CR>
map <M-j> :wincmd j<CR>
tmap <M-j> <C-\><C-n>:wincmd j<CR>
map <M-k> :wincmd k<CR>
tmap <M-k> <C-\><C-n>:wincmd k<CR>
map <M-l> :wincmd l<CR>
tmap <M-l> <C-\><C-n>:wincmd l<CR>

map <M--> :wincmd <<CR>
tmap <M--> <C-\><C-n>:wincmd <<CR>
map <M-=> :wincmd ><CR>
tmap <M-=> <C-\><C-n>:wincmd ><CR>
