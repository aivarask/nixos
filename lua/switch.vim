let g:switch_custom_definitions =
\ [
	\   { '\<\([invoxtcl]\?\)noremap\>': '\1map'},
	\   { '\<\([invoxtcl]\?\)map\>': '\1noremap'},
	\   { '\v^(\s*[*+-] )?\[ \]': '\1[x]',
	\     '\v^(\s*[*+-] )?\[x\]': '\1[-]',
	\     '\v^(\s*[*+-] )?\[-\]': '\1[ ]',
	\   },
	\   { '\v^(\s*\d+\. )?\[ \]': '\1[x]',
	\     '\v^(\s*\d+\. )?\[x\]': '\1[-]',
	\     '\v^(\s*\d+\. )?\[-\]': '\1[ ]',
	\   },
	\   ['left', 'right', 'middle'],
	\   ['yes', 'no'],
	\   ['on', 'off'],
	\   ['default', 'tabbed', 'stacking'],
	\   ['foldenable', 'nofoldenable'],
	\   ['true', 'false'],
	\   ['horizontal', 'vertical'],
	\   ['top', 'bottom'],
	\   ['hide', 'show'],
	\   ['enable', 'disable'],
	\   ['firefox', 'chromium-browser'],
	\   ['foo', 'bar', 'baz'],
	\   ['red', 'green', 'blue']
\ ]
let g:switch_mapping = ''
nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
nmap gs <Plug>(SwitchInLine)

function! SwitchLine(cnt)
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

