vim9script

if !has('nvim')
	set showtabline=2

	def g:SpawnBufferLine(): string
		var s = ''

		var bufferNums = filter(range(1, bufnr('$')), 'buflisted(v:val)')
		for i in bufferNums
			s ..= (i == bufnr()) ? ('%#TabLineSel#') : ('%#TabLine#')
			s = $'{s}{i} '	
			if bufname(i) == ''
				s = $'{s}[NEW]'
			endif
			if getbufvar(i, '&modifiable')
				s ..= fnamemodify(bufname(i), ':t')
				s ..= (getbufvar(i, "&modified")) ? (' [+] | ') : ('|')
			else
				" s ..= fnamemodify(bufname(i), ':t') .. ' [RO] |' 
			endif
		endfor
		s = $'{s}%#TabLineFill#%T'

		s = $'{s}%='	

		for i in range(1, tabpagenr('$'))  
			s ..= (i == tabpagenr()) ? ('%#TabLineSel#') : ('%#TabLine#')
			s = $'{s}%{i}T '
			s = $'{s}{i}'	
		endfor
		s = $'{s}%#TabLineFill#%T'

		if tabpagenr('$') > 1
			s = $'{s}%999X X'
		endif

		" return ''
	enddef
	set tabline=%!SpawnBufferLine()
endif
