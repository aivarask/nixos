augroup sxhkd |	autocmd! | autocmd BufWritePost sxhkdrc :!kill -SIGUSR1 $(pidof sxhkd) && notify-send 'sxhkd'
augroup dnscrypt | autocmd! | autocmd BufWritePost cloaking-rules.txt :!systemctl restart dnscrypt-proxy2.service

augroup focus
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume * :silent! checktime
	autocmd VimResized * wincmd =
augroup END

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ['CursorHold']
