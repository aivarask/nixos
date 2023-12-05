" let mapleader = '\'
" let maplocalleader = '<C-\>'
let &runtimepath.=',/etc/nixos/vim'

aug Initial
  au!
  autocmd BufEnter *.mdx setlocal ft=markdown
  autocmd BufEnter *.postcss setlocal ft=scss
  autocmd BufEnter .env* setlocal ft=sh
  autocmd BufEnter .yamllint* setlocal ft=yaml
  autocmd BufEnter *.json,flake.lock,.prettierrc setlocal ft=jsonc
  autocmd VimResized * wincmd =
  autocmd VimResized * FloatermUpdate
  autocmd BufEnter *svelte-kit/* set buftype=nowrite
  autocmd FileType * autocmd TextChanged,CursorHoldI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
  " autocmd BufWritePost *.vim,*.lua,!*/spec/*.* :call tj#save_and_exec()

  "https://github.com/tpope/vim-commentary/issues/145
  "autocmd FileType * :let b:commentary_format = &commentstring
  autocmd FileType nix setlocal commentstring=#\ %s
  autocmd FileType jsonc setlocal commentstring=//\ %s
aug END

