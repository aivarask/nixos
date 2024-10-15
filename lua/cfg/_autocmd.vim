augroup _help
	autocmd!
	autocmd BufWritePost */doc/*.txt :helptags doc
	" autocmd FileType help autocmd TextChanged,InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | update | endif
augroup END

augroup _ui
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume * :silent! checktime
	autocmd VimResized * wincmd =
	" autocmd FileType *\(.txt\|.zzz\)\@<! autocmd InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
augroup END

augroup _fold
	autocmd!
	autocmd BufEnter */systemd/*.nix setlocal fdl=4
	autocmd BufEnter */config/_.nix setlocal fdl=3
	autocmd BufEnter */{home,lua,zsh}/*.nix setlocal nofoldenable
augroup END

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ['CursorHold']
