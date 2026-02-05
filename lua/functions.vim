if !exists('*SourceLuafile')
	function! SourceLuafile() abort
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

function! Demo()
	" https://vim.fandom.com/wiki/User_input_from_a_script
	let curline = getline('.')
	call inputsave()
	let name = input('Enter name: ')
	call inputrestore()
	call setline('.', curline . ' ' . name)
endfunction


function! RegistersClear()
	let regs = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
	let i = 0
	while (i < strlen(regs))
			exec 'let @' . regs[i] . ' = ""'
			let i = i + 1
	endwhile
	unlet regs
endfunction

function! RegistersClear_()
	let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
	for r in regs
		call setreg(r, [])
	endfor
endfunction

function! Syn()
	for id in synstack(line('.'), col('.'))
		 echo synIDattr(id, 'name')
	endfor
endfunction

let g:switch_custom_definitions =
			\ [
			\   ['foldenable', 'nofoldenable'],
			\   ['true', 'false'],
			\   ['yes', 'no'],
			\   ['horizontal', 'vertical'],
			\   ['top', 'bottom'],
			\   ['hide', 'show'],
			\   ['enabled', 'disabled'],
			\   ['firefox', 'chromium-browser'],
			\   ['foo', 'bar', 'baz'],
			\   ['red', 'green', 'blue']
			\ ]
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
