let g:bclose_no_plugin_maps=1
let no_vim_maps = 1

nmap q <Nop>
nmap Q <Nop>
nnoremap <silent> <Plug>(Save) :silent write<cr>
" inoremap <Space> <C-G>u<Space>
nnoremap ZT :tabclose<CR>
nnoremap ZQ :q!<CR>

nmap <M-q> :Bclose<cr>
nmap <leader>Q :%bd\|e#<cr>

nnoremap ]] :bnext<cr>
nnoremap [[ :bprevious<cr>
map <silent> ]b :bnext<CR>
map <silent> [b :bprevious<CR>
map <silent> ]w :wincmd l<CR>
map <silent> [w :wincmd h<CR>
nnoremap <leader><space> :b#<cr>
map [c :cprevious<CR>
map ]c :cnext<CR>
map ]C :call Ctoggle()<CR>
map [C :call Ctoggle()<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>
nmap <C-k> [%
nnoremap <silent> <leader>q :Bclose<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>
"noremap <C-S-,> :left<CR>

nnoremap <M-K> :m .-2<CR>==
nnoremap <M-J> :m .+1<CR>==
inoremap <M-J> <Esc>:m .+1<CR>==gi
inoremap <M-K> <Esc>:m .-2<CR>==gi
vnoremap <M-J> :m '>+1<CR>gv=gv
vnoremap <M-K> :m '<-2<CR>gv=gv

if has('nvim')
nnoremap // :Telescope live_grep<CR>
nnoremap ?? :Telescope find_files<CR>
nnoremap <silent><leader>l :LazyGit<CR>
else
nnoremap // :Rg<CR>
nnoremap ?? :Files<CR>

nmap qq <cmd>NERDTreeToggle<CR>
nmap qQ <cmd>NERDTreeFind<CR>

nnoremap <leader><leader>c :Commands<CR>
nnoremap <leader><leader>f :Files<CR>
nnoremap <leader><leader>g :Rg<CR>
nnoremap <leader><leader>h :Helptags<CR>
nnoremap <leader><leader>k :Maps<CR>

nnoremap <silent> <leader> :<C-U>WhichKey '\'<CR>
nnoremap <silent> <leader><leader> :<C-U>WhichKey '\' '\'<CR>
nnoremap <silent> ] :<C-U>WhichKey ']'<CR>

nnoremap <F5> :source $XDG_CONFIG_HOME/vim/vimrc<CR>
nnoremap <Esc>h :wincmd h<CR>
nnoremap <Esc>j :wincmd j<CR>
nnoremap <Esc>k :wincmd k<CR>
nnoremap <Esc>l :wincmd l<CR>

cnoremap <nowait> <Esc>h <Left>
cnoremap <nowait> <Esc>l <Right>
endif

" CTRL-W    delete word to the left of cursor
" CTRL-O D  delete everything to the right of cursor
" CTRL-U    delete everything to the left of cursor
" CTRL-H    backspace/delete
" CTRL-J    insert newline (easier than reaching for the return key)
" CTRL-T    indent current line
" CTRL-D    un-indent current line
" map <M--> :wincmd <<CR>
" tmap <M--> <C-\><C-n>:wincmd <<CR>
" map <M-=> :wincmd ><CR>
" tmap <M-=> <C-\><C-n>:wincmd ><CR>

