" digraph
inoremap <C-z> <C-k>
nmap k gk
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

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

map <M-H> :wincmd H<CR>
map <M-J> :wincmd J<CR>
map <M-K> :wincmd K<CR>
map <M-L> :wincmd L<CR>

nnoremap cp "+y
vnoremap cp "+y

nnoremap <SPACE> <Nop>
map <silent> <TAB> :bn<CR>
map <silent> <S-TAB> :bp<CR>

nnoremap <M-CR> :tabnew<CR>
nnoremap <M-TAB> :tabnext<CR>
tnoremap <M-TAB> :tabnext<CR>
nnoremap <M-Del> :tabclose<CR>
nnoremap <M-q> :Bclose<CR>
nnoremap <M-Q> :Bclose!<CR>

map <silent> [q :cp<CR>
map <silent> ]q :cn<CR>

map <silent> <leader>. :vertical resize +5<CR>
map <silent> <leader>, :vertical resize -5<CR>

nmap <C-l> gc$
imap <C-l> <C-o>gc$
vmap <C-l> gc

nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
nmap <M-s> <Plug>(SwitchInLine)

nnoremap <silent> <Plug>(Save) :silent w<cr>
map <C-s> <Plug>(Save)
imap <C-s> <C-o><C-s>

nmap <leader>q :quitall<CR>
nnoremap tq :call ak#toggle_quickfix()<CR>
