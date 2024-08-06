" https://github.com/AndrewRadev/switch.vim
" https://github.com/AndrewRadev/switch.vim#builtins
let g:switch_custom_definitions =
      \ [
      \   ['<cword>', '<cWORD>', '<cexpr>', '<cfile>'],
      \ ]

fun! SwitchLine(cnt)
    " https://github.com/AndrewRadev/switch.vim/wiki/Switch-next-in-current-line
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

