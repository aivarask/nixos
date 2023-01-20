let &runtimepath.=',/etc/nixos/vim'
" set rtp+=./neotest

aug Initial
  au!
  autocmd BufEnter *.postcss setlocal ft=scss
  autocmd BufEnter .env* setlocal ft=sh
  autocmd BufEnter *.json,flake.lock setlocal ft=jsonc
  autocmd VimResized * wincmd =
  autocmd VimResized * FloatermUpdate
  autocmd BufEnter *svelte-kit/* set buftype=nowrite
  autocmd FileType * autocmd TextChanged,CursorHoldI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
  autocmd BufWritePost *.vim,*.lua :call tj#save_and_exec()
  autocmd FileType nix setlocal commentstring=#\ %s
aug END

for buf in getbufinfo()
  echo buf.name
endfor
for buf in getbufinfo({'buflisted':1})
  if buf.changed
    echo 'bufchanged'
  endif
endfor
