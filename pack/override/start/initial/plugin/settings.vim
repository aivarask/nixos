set scrolloff=6

if !exists('*SaveExec')
  function! SaveExec() abort
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

function! Ctoggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction
