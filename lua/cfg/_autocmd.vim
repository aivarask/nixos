augroup _help
	autocmd!
	autocmd BufWritePost */doc/*.txt :helptags doc
	autocmd BufWritePost sxhkdrc :!kill -SIGUSR1 $(pidof sxhkd) && notify-send 'autocmd reload'
	autocmd BufWritePost cloaking-rules.txt :!systemctl restart dnscrypt-proxy2.service
	" autocmd FileType help autocmd TextChanged,InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | update | endif
augroup END

augroup _ui
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold,VimResume * :silent! checktime
	autocmd VimResized * wincmd =
	" autocmd FileType *\(.txt\|.zzz\)\@<! autocmd InsertLeave <buffer> ++nested if &readonly == 0 && filereadable(bufname('%')) | silent update | endif
augroup END

" augroup _fold
" 	autocmd!
" 	autocmd BufEnter */systemd/*.nix setlocal fdl=4
" 	autocmd BufEnter */config/_.nix setlocal fdl=3
" 	autocmd BufEnter */{lua,zsh}/*.nix setlocal nonofoldenable
" augroup END

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ['CursorHold']

if has('nvim')
	augroup _lsp
		autocmd!
		autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })

		autocmd FileType sh,bash,zsh autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='bash-language-server'})
		" autocmd Filetype c,cpp autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='null-ls'})
		autocmd Filetype css,scss,less autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='vscode-css-language-server'})
		autocmd Filetype go autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='gopls'})
		autocmd Filetype javascript,typescript autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='tsserver'})
		"autocmd Filetype json,jsonc autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='vscode-json-language-server'})
		autocmd Filetype markdown autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='null-ls'})
		autocmd Filetype nix autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='null-ls'})
		autocmd Filetype php autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='intelephense'})
		autocmd Filetype python autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='null-ls'})
		autocmd Filetype rust autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='rust-analyzer'})
		autocmd Filetype sql autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='null-ls'})
		autocmd Filetype templ autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='templ'})
		autocmd Filetype toml autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='taplo'})
		autocmd Filetype yaml autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='yaml-language-server'})
		autocmd Filetype zig autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name='zls'})
	augroup END
endif
