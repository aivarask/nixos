augroup sxhkd |	autocmd! | autocmd BufWritePost sxhkdrc :!kill -SIGUSR1 $(pidof sxhkd) && notify-send 'sxhkd'

augroup dnscrypt
	autocmd!
	autocmd BufWritePost cloaking-rules.txt :!systemctl restart dnscrypt-proxy2.service
augroup END

augroup focus
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd VimResized * wincmd =
augroup END

if has('nvim')
  autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
endif


