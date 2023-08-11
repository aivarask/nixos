" https://github.com/junegunn/fzf.vim#commands
nnoremap <leader><leader>/ :History/<CR>
nnoremap <leader><leader>: :History:<CR>
nnoremap <leader><leader>F :FZF<CR>
nnoremap <leader><leader>G :Rg <C-r><C-w><CR>
nnoremap <leader><leader>a :call tj#save_and_exec()<CR>
nnoremap <leader><leader>b :Buffers<CR>
nnoremap <leader><leader>c :Commands<CR>
nnoremap <leader><leader>f :Files<CR>
nnoremap <leader><leader>r :Files src/routes<CR>
nnoremap <leader><leader>l :Files src/lib<CR>
nnoremap <leader><leader>g :Rg<CR>
nnoremap <leader><leader>h :Helptags<CR>
nnoremap <leader><leader>m :Maps<CR>

nnoremap <leader>lf :LfCurrentDirectory<CR>
nnoremap <leader>lg :LazyGit<CR>
nnoremap <leader>lt :LfNewTab<CR>
nnoremap <leader>lw :LfWorkingDirectory<CR>

nnoremap <C-s> :silent w<CR>
inoremap <silent><C-s> <C-o>:silent w<CR>
