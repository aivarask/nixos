nnoremap <SPACE> <Nop>

" nnoremap <F1> :exe 'vert bo h ' . expand('<cword>')<CR>
map <F1> :exe 'h ' . expand('<cWORD>')<CR>
" inoremap <F1> <C-o>:exe 'h ' . expand('<cWORD>')<CR>
map <F13> :exe 'h ' . expand('<cword>')<CR>
inoremap <F13> <C-o>:exe 'h ' . expand('<cword>')<CR>
map <F25> :exe 'h ' . expand('<cword>')<CR>
inoremap <F25> <C-o>:exe 'h ' . expand('<cword>')<CR>

nnoremap <F2> :exe '!xdg-open https://github.com/' . expand('<cfile>')<CR>
nnoremap <F3> :exe '!xdg-open https://github.com/search\?q\=' . expand('<cWORD>')<CR>
nnoremap <F4> :set paste!<CR>

map <F5> :so%<CR>
inoremap <F5> <C-o>:so%<CR>
map <C-b> :.so<CR>
inoremap <C-b> <C-o>:.so<CR>

map <F9> :vsplit /etc/nixos/vim/lua/snippets/svelte.json<CR>
map <F21> :vsplit /etc/nixos/vim/lua/snippets/typescript.json<CR>
map <F33> :vsplit /etc/nixos/vim/lua/snippets/test.json<CR>
" map <F33> :lua require('completion').reload()<CR>

function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction
map tq :call ToggleQuickFix()<cr>
map <F12> :FloatermToggle<CR>

if !has ('nvim')
  tnoremap <F12> <C-W>:FloatermToggle<CR>
else
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
  tnoremap	<silent>	<F12>	<C-\><C-n>:FloatermToggle<CR>
endif

nnoremap <leader>tt <cmd>Telescope<cr>

augroup aivarask
  autocmd!
  autocmd FileType * autocmd TextChanged,InsertLeave <buffer> if &readonly == 0 && &buftype == '' | silent write | endif
  autocmd BufWritePost completion.lua lua require("completion").reload() 
  autocmd BufWritePost */snippets/*.json lua require("completion").reload() 
augroup END

nnoremap <silent><C-s> :silent w<CR>
inoremap <silent><C-s> <C-o>:silent w<CR>
nnoremap <M-q> :Bclose<CR>

map <TAB> :bn<CR>
map <S-TAB> :bp<CR>

map <C-w>f <C-w>vgf
map <C-w>d <C-w>vgd
map <silent>gF :vert bo e <cfile><CR>

nmap <C-l> gc$
imap <C-L> <C-o>gc$
vmap <C-l> gc

nnoremap	<leader>li	:LspInfo<CR>
nnoremap	<leader>lr	:LspRestart<CR>
nnoremap  <leader>lg  :LazyGit<CR>

" https://github.com/junegunn/fzf.vim#commands
nnoremap <leader>sm :Maps<CR>
nnoremap <C-e> :Files<CR>
" nnoremap <C-e>. :Files ..<CR>
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sc :Commands<CR>
nnoremap <leader>sF :FZF<CR>

nnoremap <C-g> :Rg <CR>
nnoremap <C-h> ZZ
nnoremap <leader>sr :Rg<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sb :Buffers<CR>

nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <Leader>da :Lexplore<CR>

nnoremap <leader>lf :LfCurrentDirectory<CR>

" SHIFT-ESC:
" inoremap <Esc>[Z <Esc> :bn<CR>

"moving lines
nmap j gj
nmap k gk
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Prisma shell alias
nnoremap <space>pa :FloatermNew pa <bar> :LspRestart<CR>
nnoremap <space>pdp :FloatermNew pdp<CR>
nnoremap <space>pdr :FloaterNew pdr<CR>
nnoremap <space>pds :FloatermNew pds<CR>
nnoremap <space>pg :FloatermNew pg <bar> :LspRestart<CR>



