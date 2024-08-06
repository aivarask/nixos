vim.cmd [[
map <leader><leader>m :messages<CR>
map <leader><leader>q :quitall<CR>
map <leader><leader>c :call Ctoggle()<CR>
map <silent> [c :cprevious<CR>
map <silent> ]c :cnext<CR>
map <leader><leader>s :Subvert/<C-r><C-w>//g<Left><Left>
map <leader><leader>S :%Subvert/<C-r><C-w>//g<Left><Left>
map <leader><leader>a :call SaveExec()<CR>

map <leader><leader>+ "+y

map <leader><leader>t :tabnew<CR>
map <leader><leader>T :tabclose<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>

]]
