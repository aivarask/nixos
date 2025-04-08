if !exists('*SaveExec')
	function! SaveExec() abort
		if &filetype ==?'vim'
			" :%s/\s\+$//e
			:silent! write
			:source %
		elseif &filetype ==?'lua'
			:silent! write
			:luafile %
		else
		endif
		:edit | call feedkeys('zx')
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

let g:switch_mapping = ''
nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
nmap gs <Plug>(SwitchInLine)

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
