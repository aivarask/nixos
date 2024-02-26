aug Other
  au!
  autocmd BufEnter *svelte-kit/* set buftype=nowrite
  autocmd VimResized * wincmd =
  autocmd FileType * autocmd TextChanged,CursorHoldI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
aug END
