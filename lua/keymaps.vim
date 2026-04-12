let g:bclose_no_plugin_maps=1
let g:no_vim_maps=1

nmap q <Nop>
nmap Q <Nop>
nnoremap <silent> <Plug>(Save) :silent write<cr>
nnoremap ZQ :q!<CR>
nmap <M-Q> :<cr>
nmap <leader>Q :%bd\|e#<cr>
nnoremap <silent> <leader>q :bd!<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>

nnoremap <silent> ]= :tabnext<CR>
nnoremap <silent> [- :tabprevious<CR>
map <silent> ]] :bnext<CR>
map <silent> [[ :bprevious<CR>
tmap <silent> ]] <C-\><C-N>:bnext<CR>
tmap <silent> [[ <C-\><C-N>:bprevious<CR>

nnoremap <silent> [<BS> :b#<CR>
nnoremap <silent> ]<BS> :b#<CR>
nnoremap <silent> ]\ :wincmd w<CR>
nnoremap <silent> [' :wincmd p<CR>

inoremap jk <Esc>

inoremap <M-h> <C-O><Left>
inoremap <M-j> <C-O><Down>
inoremap <M-k> <C-O><Up>
inoremap <M-l> <C-O><Right>
nnoremap <M-K> :m .-2<CR>==
nnoremap <M-J> :m .+1<CR>==
inoremap <M-J> <Esc>:m .+1<CR>==gi
inoremap <M-K> <Esc>:m .-2<CR>==gi
vnoremap <M-J> :m '>+1<CR>gv=gv
vnoremap <M-K> :m '<-2<CR>gv=gv

" let scroll=8
 "map <Space> 8<C-E>
" map <S-Space> 8<C-Y>
" imap <C-Space> 

nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>

"autocmd! nvim.terminal TermClose
nnoremap /, :execute 'terminal lf ' .. expand("%:h")<CR>
nnoremap qq :Lexplore<CR>
nnoremap // :Rg<CR>
nnoremap /. :Files<CR>
nnoremap <F5> :source $XDG_CONFIG_HOME/vim/vimrc<CR>
" nnoremap <silent> <leader><leader> :<C-U>WhichKey '\' '\'<CR>
" nnoremap <silent> <leader> :<C-U>WhichKey '\'<CR>
" nnoremap <silent> ] :<C-U>WhichKey ']'<CR>

nnoremap <leader><leader>c :Commands<CR>
nnoremap <leader><leader>f :Files<CR>
nnoremap <leader><leader>g :Rg<CR>
nnoremap <leader><leader>h :Helptags<CR>
nnoremap <leader><leader>k :Maps<CR>

