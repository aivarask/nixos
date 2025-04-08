augroup sxhkd |	autocmd! | autocmd BufWritePost sxhkdrc :!kill -SIGUSR1 $(pidof sxhkd) && notify-send 'sxhkd'

augroup dnscrypt
	autocmd!
	autocmd BufWritePost cloaking-rules.txt :!systemctl restart dnscrypt-proxy2.service
augroup END

augroup focus
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume * :silent! checktime
	autocmd VimResized * wincmd =
augroup END
