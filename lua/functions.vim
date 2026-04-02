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

function! RuntimepathList() 
	exe "new | put =split(" . expand(&runtimepath) . ",  ',')"
endfunction

function! Ctoggle()
	if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else cclose | endif
endfunction

function! InputFromScript()
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
			execute 'let @' . regs[i] . ' = ""'
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
