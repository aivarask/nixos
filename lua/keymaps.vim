let g:bclose_no_plugin_maps=1
let no_vim_maps = 1
map q <nop>
map Q <nop>
nnoremap <silent> <Plug>(Save) :silent write<cr>
" inoremap <Space> <C-G>u<Space>
nmap <M-q> :Bclose<cr>
nmap <leader>Q :%bd\|e#<cr>

nmap <silent> <Tab>l :bnext<cr>
nmap <silent> <Tab><Tab> :bnext<cr>
nmap <silent> <Tab><S-Tab> :bprevious<cr>
nmap <silent> <S-Tab><S-Tab> :bprevious<cr>
nmap <silent> <Tab>h :bprevious<cr>
nnoremap ]] :bnext<cr>
nnoremap [[ :bprevious<cr>
map <silent> ]b :bnext<CR>
map <silent> [b :bprevious<CR>
map <silent> ]w :wincmd l<CR>
map <silent> [w :wincmd h<CR>
nnoremap <leader><tab> :bnext<cr>
nnoremap <leader><space> :b#<cr>
map [c :cprevious<CR>
map ]c :cnext<CR>
map ]C :call Ctoggle()<CR>
map [C :call Ctoggle()<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>
nnoremap ZT :tabclose<CR>
nmap <C-k> [%
nnoremap <silent> <leader>q :Bclose<CR>
nnoremap <silent> <leader>a :call SourceLuafile()<CR>
nnoremap <silent> <leader>l :LazyGit<CR>
"noremap <C-S-,> :left<CR>
nnoremap ?? :Telescope find_files<CR>
nnoremap ?a :edit ~/.alias<CR>
nnoremap ?e :edit /etc/nixos/.editorconfig<CR>
nnoremap ?f :edit /etc/nixos/flake.nix<CR>
nnoremap ?z :edit $ZDOTDIR/.zshrc_<CR>
nnoremap ?s :edit ~/.config/sway/config<CR>
nnoremap ?k :edit ~/.config/nvim/keymaps.vim<CR>
nnoremap ?v :edit ~/.config/nvim/shared.vim<CR>
nnoremap ?p :edit ~/.config/pistol/pistol.conf<CR>
nnoremap ?w :tabe /root/.config/waybar/config.jsonc<CR> :vertical split ~/.config/waybar//style.css
"~/.config/waybar/style.css  <CR>

nnoremap <M-J> :m .+1<CR>==
nnoremap <M-K> :m .-2<CR>==
inoremap <M-J> <Esc>:m .+1<CR>==gi
inoremap <M-K> <Esc>:m .-2<CR>==gi
vnoremap <M-J> :m '>+1<CR>gv=gv
vnoremap <M-K> :m '<-2<CR>gv=gv
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

