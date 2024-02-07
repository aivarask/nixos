" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --ignore-file "$HOME/.config/git/ignore" --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  " f = { [[:Files<CR>]], ':Files' },
" nmap <leader><tab> <plug>(fzf-maps-n)

" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')



" https://github.com/junegunn/fzf.vim#commands
nmap <c-x>/ :History/<cr>
nmap <c-x>: :History:<cr>
nmap <c-x>G :RG<cr>
nmap <c-x>b :Buffers<cr>
nmap <c-x>c :Commands<cr>
nmap <c-x>f :Files<cr>
nmap <c-x>g :Rg<cr>
nmap <c-x>h :Helptags<cr>
nmap <c-x>j :Jumps<cr>
nmap <c-x>m :Marks<cr>
" custom
nmap <c-x>F :FZF<cr>
nmap <c-x>H :Rg http<cr>
nmap <c-x>M :Maps<cr>
nmap <c-x>w :Rg <c-r><c-w><cr>


" https://github.com/junegunn/fzf.vim#customization
let g:fzf_vim = {}
" let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8  }  }
" let g:fzf_preview_window = ['hidden,right,50%,<70(up,60%)', 'ctrl-]']


