augroup nixos.edit
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume,FileChangedShellPost * :silent! checktime
	autocmd VimResized * wincmd =
	autocmd BufLeave,FocusLost * silent! wall

augroup END

if has('nvim')
  autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
endif


