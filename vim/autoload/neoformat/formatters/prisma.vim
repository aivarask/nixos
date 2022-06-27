function! neoformat#formatters#prisma#enabled() abort
	return ['prisma_fmt']
endfunction

function! neoformat#formatters#prisma#prisma_fmt() abort
    return {
        \ 'exe': 'prisma-fmt',
        \ 'args': ['format'],
        \ 'stdin': 1
        \ }
endfunction
