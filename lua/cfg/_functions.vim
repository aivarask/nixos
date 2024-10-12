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
			:edit
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

function! Demo()
	" https://vim.fandom.com/wiki/User_input_from_a_script
	let curline = getline('.')
	call inputsave()
	let name = input('Enter name: ')
	call inputrestore()
	call setline('.', curline . ' ' . name)
endfunction

