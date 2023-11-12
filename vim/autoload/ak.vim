function! ak#prisma_db_push() abort
  :FloatermNew --wintype=vsplit --width=0.4 --autoclose=1 npx prisma db push
  :LspRestart
endfunction

function! ak#toggle_help()
  if empty(filter(getwininfo(), 'v:val.help'))
    copen
  else
    cclose
  endif
endfunction

function! ak#toggle_quickfix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction


function! ak#toggle_help()
  if empty(filter(getwininfo(), 'v:val.help'))
    copen
  else
    cclose
  endif
endfunction



" $state
" _
" a
" ab
" __
" {}
" {_('welcome')}
" $: console.log(_)
" set iskeyword-=_
set iskeyword+=$
function! ak#toggle_dollar()
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

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-file "$HOME/.config/git/ignore" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" https://salferrarello.com/vim-close-all-buffers-except-the-current-one/
command! CloseRestBuffers execute 'up|%bd|e#|normal`"'
