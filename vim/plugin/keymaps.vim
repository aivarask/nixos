nnoremap <F5> :match Search /<C-R><C-W>/<CR>

if !has ('nvim')
  nnoremap <F12> :FloatermToggle<CR>
  tnoremap <F12> <C-W>:FloatermToggle<CR>
endif

" https://github.com/junegunn/fzf.vim#commands
nnoremap <leader><leader>m :Maps<CR>
nnoremap <leader><leader>f :Files<CR>
nnoremap <leader><leader>c :Commands<CR>
nnoremap <leader><leader>F :FZF<CR>
nnoremap <leader><leader>g :Rg<CR>
nnoremap <leader><leader>G :Rg <C-r><C-w><CR>
nnoremap <leader><leader>o :SymbolsOutline<CR>
nnoremap <leader><leader>h :Helptags<CR>
nnoremap <leader><leader>b :Buffers<CR>
nnoremap <leader><leader>: :History:<CR>
nnoremap <leader><leader>/ :History/<CR>

" digraph
inoremap <C-z> <C-k>

nmap k gk
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

map <M-1> <C-w>h
map <M-2> <C-w>l

map <M-[> <C-w>h
map <M-]> <C-w>l
map <M-h> <C-w>h
map <M-l> <C-w>l

nnoremap <M-CR> :tabnew<CR>
nnoremap <M-TAB> :tabnext<CR>
nnoremap <M-Del> :tabclose<CR>

cnoremap <M-h> <Left>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>

imap <M-d><M-d> <C-o>dd
imap <M-y><M-y> <C-o>yy

" imap <M-o><M-o> <C-o>o
" imap <M-o>o <C-o>o
imap <M-o> <C-o>o
imap <M-O> <C-o>O

nnoremap <leader>lg :LazyGit<CR>
nnoremap <leader>lf :LfCurrentDirectory<CR>
nnoremap <leader>lw :LfWorkingDirectory<CR>
nnoremap <leader>lt :LfNewTab<CR>

" various
nnoremap <leader><leader>x :call tj#save_and_exec()<CR>
nnoremap <leader>q :quitall<CR>
map tq :call ak#toggle_quickfix()<cr>

nnoremap <C-s> :silent w<CR>
inoremap <silent><C-s> <C-o>:silent w<CR>

nnoremap <M-q> :Bclose<CR>
nnoremap <M-Q> :Bclose!<CR>

" https://salferrarello.com/vim-close-all-buffers-except-the-current-one/
command! CloseRestBuffers execute 'up|%bd|e#|normal`"'
nnoremap <leader>dd :CloseRestBuffers<CR>

" comments/helpers
nmap <C-c> O/** */<C-o>B
nmap <C-t> O<!-- --><C-o>B
nnoremap <leader>4 :call ak#toogle_dollar()<CR>
nnoremap <space>4 :call ak#toogle_dollar()<CR>
nmap <C-l> gc$
imap <C-l> <C-o>gc$
vmap <C-l> gc

" windows/panels/buffers
map <TAB> :bn<CR>
map <S-TAB> :bp<CR>

map <C-w>f <C-w>vgf
map <C-w>d <C-w>vgd
map <silent>gF :vert bo e <cfile><CR>

nnoremap <SPACE> <Nop>
