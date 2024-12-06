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
