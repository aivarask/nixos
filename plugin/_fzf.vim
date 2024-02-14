" https://github.com/junegunn/fzf.vim
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', 'pistol {}']}, <bang>0)
nmap <c-x>! :🟢 CTRL-T, CTRL-X, CTRL-V
nmap <c-x>/ :History/<cr>
nmap <c-x>: :History:<cr>
nmap <c-x>F :History<cr>
nmap <c-x>G :RG<cr>
nmap <c-x>H :Rg http<cr>
nmap <c-x>L :Locate <c-r><c-w>
nmap <c-x>M :Maps<cr>
nmap <c-x>b :Buffers<cr>
nmap <c-x>c :Commands<cr>
nmap <c-x>f :Files<cr>
nmap <c-x>g :Rg<cr>
nmap <c-x>h :Helptags<cr>
nmap <c-x>j :Jumps<cr>
nmap <c-x>l :Locate 
nmap <c-x>m :Marks<cr>
nmap <c-x>w :Rg <c-r><c-w><cr>
