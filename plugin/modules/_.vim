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


function! MetaPosition()
  " go go-org goo go-not-exist
  let p = expand("<cword>")
  let o = system("nix eval nixpkgs\#" . p . '.meta.position')
  if !v:shell_error
    let [f, l] = o->substitute("\\n", "", "g")->substitute("\"", "", "g")->split(":")
    execute 'edit ' f | execute "normal " .. l .. "G"
  else
    echomsg o
  endif
endfunction
