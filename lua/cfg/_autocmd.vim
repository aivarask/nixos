augroup sxhkd |	autocmd! | autocmd BufWritePost sxhkdrc :!kill -SIGUSR1 $(pidof sxhkd) && notify-send 'sxhkd'

augroup _help
	autocmd!
	autocmd BufWritePost */doc/*.txt :helptags doc
	autocmd BufWritePost cloaking-rules.txt :!systemctl restart dnscrypt-proxy2.service
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

if has('nvim')
	augroup _lsp
		autocmd!
		autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
	augroup END
endif
