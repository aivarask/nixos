augroup vimrc_help
  autocmd!
	autocmd BufEnter *.txt if &buftype == 'help' && winwidth('%') > 140 | wincmd L | endif
	autocmd FileType help autocmd TextChanged,CursorHoldI,InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | update | endif
	autocmd BufWritePost */doc/*.txt :helptags doc
augroup END

augroup vimrc_save
	au!
	au FocusGained,BufEnter * :silent! checktime
	autocmd VimResized * wincmd =
	autocmd FileType *\(.txt\|.diffs\)\@<! autocmd TextChanged,CursorHoldI,InsertLeave <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
augroup END


