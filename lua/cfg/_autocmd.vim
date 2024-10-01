augroup _help
  autocmd!
	autocmd FileType help,man if winwidth('%') > 140 | wincmd L | endif
	autocmd BufWritePost */doc/*.txt :helptags doc
	" autocmd FileType help autocmd TextChanged,InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | update | endif
augroup END

augroup _ui
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume * :silent! checktime
	autocmd VimResized * wincmd =


	" autocmd FileType *\(.txt\|.zzz\)\@<! autocmd InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
augroup END


let g:auto_save = 1
let g:auto_save_silent = 1 
let g:auto_save_events = ['CursorHold']
