if !exists('*_#save_and_exec')
  function! _#save_and_exec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif
    return
  endfunction
endif


function! _#RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-file "$HOME/.config/git/ignore" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" https://salferrarello.com/vim-close-all-buffers-except-the-current-one/
command! CloseRestBuffers execute 'up|%bd|e#|normal`"'
