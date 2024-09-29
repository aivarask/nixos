augroup _help
  autocmd!
	autocmd FileType help,man if winwidth('%') > 140 | wincmd L | endif
	autocmd FileType help autocmd TextChanged,InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | update | endif
	autocmd BufWritePost */doc/*.txt :helptags doc
augroup END

augroup _save
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume * :silent! checktime
	autocmd VimResized * wincmd =
	autocmd FileType *\(.txt\|.diffs\)\@<! autocmd TextChanged,InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
augroup END


