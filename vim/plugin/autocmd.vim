aug Initial
  au!
  autocmd BufEnter */zsh/* setlocal ft=zsh
  autocmd BufEnter *.templ setlocal ft=templ
  autocmd BufEnter *.mdx setlocal ft=markdown
  autocmd BufEnter *.postcss setlocal ft=scss
  autocmd BufEnter .env* setlocal ft=sh
  autocmd BufEnter *.json,flake.lock,.prettierrc setlocal ft=jsonc
  autocmd VimResized * wincmd =
  autocmd VimResized * FloatermUpdate
  autocmd BufEnter *svelte-kit/* set buftype=nowrite
  autocmd FileType * autocmd TextChanged,CursorHoldI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
aug END


