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

function! MimeType(filename) abort
  if !executable('file')
    throw 'No ''file'' in ' . $PATH
  endif

  let l:output = systemlist('file --mime-type ' . shellescape(a:filename))
  if v:shell_error !=# 0 || len(l:output) ==# 0
    throw 'Command error: ''file --mime-type'': ' . join(l:output, "\n")
  endif

  let l:file_output = l:output[0]
  let l:mimetype = substitute(l:file_output, '\v^.*\:\s*(.*)\s*$', '\1', '')
  if l:mimetype ==# '' || stridx(l:mimetype, '/') ==# -1
    return 'The MIME type could not be detected'
  endif

  return l:mimetype
endfunction
