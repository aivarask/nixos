augroup nixos
	autocmd! 
	autocmd BufWritePost sxhkdrc :!/run/current-system/sw/bin/kill -SIGUSR1 --verbose $(pidof sxhkd)
	autocmd BufWritePost cloaking-rules.txt :!systemctl restart dnscrypt-proxy2.service
augroup END


augroup nixos.edit
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd VimResized * wincmd =
augroup END

if has('nvim')
  autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
endif


