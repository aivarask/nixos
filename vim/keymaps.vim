nnoremap <SPACE> <Nop>
"inoremap II <Esc>I
"inoremap AA <Esc>A
"inoremap OO <Esc>O
""
"inoremap CC <Esc>C
"inoremap SS <Esc>S
"inoremap DD <Esc>dd
inoremap UU <Esc>u

nnoremap HH <C-w>t<C-w>H
nnoremap KK <C-w>t<C-w>K

map   <F1>  :exe 'help ' . expand('<cword>')<CR>
imap  <F1>  <C-o><F1>
map   <F13> :exe 'help ' . expand('<cWORD>')<CR>
imap  <F13> <C-o><F13>
map   <F25> :exe 'help ' . expand('<cexpr>')<CR>
imap  <F25> <C-o><F25>

map   <F2>  <cmd>lua vim.lsp.buf.hover()<CR>
imap  <F2>  <C-o><F2>

map   <F3>  <cmd>lua vim.lsp.buf.signature_help()<CR>
imap  <F3>  <C-o><F3>

map   <F5>  :source %<CR>
imap  <F5>  <C-o><F5>
map   <F17> :so /root/.config/nvim/init.lua<CR>
imap  <F17> <C-o><F17>
map   <F29> :so /root/.config/nvim/init.lua<CR>
imap  <F29> <C-o><F29>

map   <F6>  <cmd>lua ReloadModule('<cword>')<CR>
map   <F18> <cmd>lua ReloadModule('<cWORD>')<CR>
map   <F30> <cmd>lua ReloadModule('<cexpr>')<CR>

map   <F7>  <cmd>lua ReloadFile('<cword>')<CR>
imap  <F7>  <C-o><F7>

map <F8> :e /etc/nixos/vim/init.lua<CR>
map <F20> :e /etc/nixos/vim/settings.vim<CR>
map <F32> :e /etc/nixos/vim/keymaps.vim<CR>

map <F9> :e /etc/nixos/vim/lua/snippets/svelte.json<CR>
map <F21> :e /etc/nixos/vim/lua/snippets/typescript.json<CR>
map <F33> :e /etc/nixos/vim/lua/snippets/test.json<CR>
" map <F33> :lua require('completion').reload()<CR>

imap <F12> <C-O>:FloatermToggle<CR>


" nnoremap <F2> :exe '!xdg-open https://github.com/' . expand('<cfile>')<CR>
" nnoremap <F3> :exe '!xdg-open https://github.com/search\?q\=' . expand('<cWORD>')<CR>
" nnoremap <F4> :set paste!<CR>

" map <C-b> :.so<CR>
" inoremap <C-b> <C-o>:.so<CR>


map   qq    <cmd>NvimTreeToggle<CR> 
function! Greet() abort
  echo 'hello from keymaps.vim'
endfunction
" execute Greet()

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

nnoremap <leader>tt <cmd>Telescope<CR>
nnoremap <leader>ds <cmd>Telescope lsp_document_symbols<CR>

augroup aivarask
  autocmd!
  autocmd FileType * autocmd TextChanged,InsertLeave <buffer> if &readonly == 0 && &buftype == '' | silent write | endif
  autocmd BufWritePost completion.lua lua require("completion").reload() 
  autocmd BufWritePost */snippets/*.json lua require("completion").reload() 
augroup END

nnoremap <silent><C-s> :silent w<CR>
inoremap <silent><C-s> <C-o>:silent w<CR>
inoremap <C-b> <Cmd>lua require('cmp').complete({ config = { sources = { { name = 'luasnip' } } } })<CR>
nnoremap <M-q> :Bclose<CR>
command BcloseRest :up | %bd | e#
nnoremap <leader>dd :BcloseRest<CR>

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

" $page $lang $store
set iskeyword+=$
function! ToggleDollar()
  let l:pos = col('.')
  if expand('<cword>') =~ '\$'
    " if expand('<cword>') =~ '\v(\s+|\t+)?$'
    echo 'contains'
    exec 'normal! bx'
    let l:pos -= 1
  else
    echo 'else'
    exec 'normal! bi$'
    let l:pos += 1
  endif
  call cursor(line("."), l:pos)
endfunction

nnoremap <leader>4 :call ToggleDollar()<CR>
nnoremap <space>4 :call ToggleDollar()<CR>

" https://github.com/junegunn/fzf.vim#preview-window
let g:fzf_preview_window = ['up:60%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8  }  }


function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-file "$HOME/.config/git/ignore" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" https://github.com/junegunn/fzf.vim#commands
nnoremap <leader>sm :Maps<CR>
" nnoremap <C-e>. :Files ..<CR>
nnoremap <leader>sf :Files<CR>
nnoremap <C-e> :Files<CR>
nnoremap <leader>sc :Commands<CR>
nnoremap <leader>sF :FZF<CR>
nnoremap <C-g> :RG <CR>

nnoremap <C-h> ZZ
nnoremap <leader>sr :Rg<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sb :Buffers<CR>

" nnoremap <leader>dd :Lexplore %:p:h<CR>
" nnoremap <Leader>da :Lexplore<CR>

nnoremap <leader>lf :LfCurrentDirectory<CR>
nnoremap <leader>lw :LfWorkingDirectory<CR>
nnoremap <leader>lt :LfNewTab<CR>

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



