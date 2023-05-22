nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
nmap <M-x> <Plug>(SwitchInLine)
" const

" https://github.com/AndrewRadev/switch.vim
autocmd FileType markdown let b:switch_custom_definitions =
      \ [
      \   { '\v^(\s*[*+-] )?\[ \]': '\1[x]',
      \     '\v^(\s*[*+-] )?\[x\]': '\1[-]',
      \     '\v^(\s*[*+-] )?\[-\]': '\1[ ]',
      \   },
      \   { '\v^(\s*\d+\. )?\[ \]': '\1[x]',
      \     '\v^(\s*\d+\. )?\[x\]': '\1[-]',
      \     '\v^(\s*\d+\. )?\[-\]': '\1[ ]',
      \   },
      \ ]

let g:switch_custom_definitions =
      \ [
      \   ['<cword>', '<cWORD>', '<cexpr>', '<cfile>'],
      \   ['type=\"number\"', 'type=\"text\"'],
      \   ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
      \   ['foo', 'bar', 'baz'],
      \   ['Less', 'Greater'],
      \   ['Truthy', 'Falsy'],
      \   ['export let', 'export const'],
      \   ['const', 'export const'],
      \   ['Int', 'String', 'Boolean'],
      \   {
      \     '\(\k\+=\){\([[:keyword:].]\+\)}':      '\1{`${\2}`}',
      \     '\(\k\+=\){`${\([[:keyword:].]\+\)}`}': '\1{\2}',
      \   },
      \   ['it(', 'it.skip(', 'it.only('],
      \   ['test(', 'test.skip(', 'test.only('],
      \   ['describe(', 'describe.skip(', 'describe.only('],
      \   ['toBeTruthy', 'toBeFalsy'],
      \   ['toBe(', 'not.toBe('],
      \   ['TODO', 'DONE'],
      \   ['FIX', 'ISSUE', 'BUG'],
      \   ['NOTE', 'INFO'],
      \ ]
      " \   ['const', 'let'],
      " \   ['info', 'warning', 'error', 'hint', 'test'],
" \   ['string', 'number', 'bigint', 'symbol', 'object', 'boolean', 'function', 'undefined']

" https://github.com/AndrewRadev/switch.vim/wiki/Switch-next-in-current-line
fun! SwitchLine(cnt)
    let tick = b:changedtick
    let start = getcurpos()
    for n in range(a:cnt)
        Switch
    endfor
    if b:changedtick != tick
        return
    endif
    while v:true
        let pos = getcurpos()
        normal! w
        if pos[1] != getcurpos()[1] || pos == getcurpos()
            break
        endif
        for n in range(a:cnt)
            Switch
        endfor
        if b:changedtick != tick
            return
        endif
    endwhile
    call setpos('.', start)
endfun

