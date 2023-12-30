" set iskeyword+=$

function! Store()
  let l:val = expand('<cword>')
  let l:pos = col('.')
  let l:back = strchars(val)
  let inner = ''
  if strchars(val) > 1
    let inner .= 'b'
  endif
  if val =~ '\$'
    exec 'normal! '.inner.'x'
    let l:pos -= 1
  else
    exec 'normal! '.inner.'i$'
    let l:pos += 1
  endif
  call cursor(line("."), l:pos)
endfunction

function! Foo()
    echom "yes"
endfunction
command! -buffer Foo call Foo()
