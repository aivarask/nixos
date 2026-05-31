" vim: foldmethod=indent foldnestmax=1

function! Progname()
	return v:progname
endfunction

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

command! -nargs=+ Gr execute 'silent grep! <args>' | :exe 'copen ' . &scrolloff
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr Grep(<f-args>)
function! Grep(...) 
	return system(join([&grepprg] + a:000), ' ')	      
endfunction

function FoldText()
	let line = getline(v:foldstart)
	let ln = v:foldend - v:foldstart + 1
	let sub = line
	return v:folddashes .. ' ' .. ln .. ' ' .. sub
endfunction

function! FindFunc(cmdarg, cmdcomplete)
	let files = glob("`fd -H `", 1, 1)
	" let items = substitute(files, "\n", ",", "g")
	" let files = glob(".*", 1, 1)
	return a:cmdarg == '' ? files : matchfuzzy(files, a:cmdarg)
endfunc

function! FindFuncGlob(cmdarg, cmdcomplete)
	let pat = a:cmdcomplete ? $'{a:cmdarg}*' : a:cmdarg
	return glob(pat, v:false, v:true)
endfunc

function! FindGitFiles(cmdarg, cmdcomplete)
	let fnames = systemlist('git ls-files')
	return fnames->filter('v:val =~? a:cmdarg')
endfunc

command! -nargs=1 FindFiles call FindFiles(<q-args>)
function! FindFiles(filename)
	let error_file = tempname()
	silent exe '!fd -t f '.a:filename.' | xargs file | sed "s/:/:1:/" > '.error_file
	set errorformat=%f:%l:%m
	exe "cfile ". error_file
	copen
endfunction

command! SC vnew | setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile | nnoremap <buffer> ,s :silent %source<CR> 
command! DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis

function! TabLine()
	let s = ''
	" Making a tab list on the right side
	for i in range(1, tabpagenr('$'))  " Loop through the number of tabs
		let s .= (i == tabpagenr()) ? ('%#TabLineSel#') : ('%#TabLine#')
		let s .= '%' . i . 'T '  " set the tab page number (for mouse clicks)
		let s .= i . ' '          " set page number string
	endfor
	let s .= '%#TabLineFill#%T'  " Reset highlight
	if tabpagenr('$') > 1
		let s .= '%999X X '
	endif
	" Get the list of buffers. Use bufexists() to include hidden buffers
	let bufferNums = filter(range(1, bufnr('$')), 'buflisted(v:val)')
	for i in bufferNums
		let s .= (i == bufnr()) ? ('%#TabLineSel#') : ('%#TabLine#')
		let s .=' ' 
		" let s .=' ' . i . '' 
		if bufname(i) == ''
			let s .= '[No Name]'
		endif
		if getbufvar(i, "&modifiable")
			let s .= fnamemodify(bufname(i), ':t') 
			" let s .= pathshorten(bufname(i)) 
			let s .= (getbufvar(i, "&modified")) ? ('+') : ('')
		else
			let s .= fnamemodify(bufname(i), ':t') . '-'
		endif
		let s .= ' '
	endfor
	let s .= '%#TabLineFill#%T'  " Reset highlight
	let s .= '%=' " Spacer
	return s
endfunction

function! TermFloat(arg = "zsh")
	let buf = term_start([a:arg], #{hidden: 1, term_finish: 'close'})
	let winid = popup_create(buf, #{minwidth: 120, minheight: 40})
endfunction

command! -bang -nargs=* Term call Term(<f-args>)
function! Term(arg = "zsh") abort
	echom a:arg
	let tname = '!' . a:arg
	if has('nvim') | let tname = 'term:/' | endif
	let bnr = bufnr(tname)
	let wnr = bufwinnr(tname)
	if wnr > 0 && winnr('$') > 1
		execute wnr . 'wincmd c'
	elseif bnr > 0 && bnr != bufnr(@%)
		execute 'sb ' . bnr
	elseif bnr == bufnr(@%)
		execute 'bprevious | sb ' . bnr . ' | wincmd p'
	else
		if has('nvim') | execute 'sb | edit term://' . a:arg | else | execute 'terminal ++close ' . a:arg | endif
	endif
endfunction

function! Exec(command)
	redir! >>.vim_ex_log.txt
	silent exec a:command
	redir END
	" return output
endfunction

function! Woo()
	echom complete_info()
	" startinsert
	return "\<Ignore>"
endfunction

function! Bclose(bang, buffer)
	if empty(a:buffer)
		let btarget = bufnr('%')
	elseif a:buffer =~ '^\d\+$'
		let btarget = bufnr(str2nr(a:buffer))
	else
		let btarget = bufnr(a:buffer)
	endif
	execute 'bdelete' btarget
endfunction

if !exists('*SourceLuafile')
endif
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

function! RuntimepathList() 
	:exe "new | put =split(" . expand(&runtimepath) . ",  ',')"
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
