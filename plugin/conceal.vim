augroup mine
	autocmd!
	" https://learnvimscriptthehardway.stevelosh.com/
	" https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#pulseaudiomodules
	autocmd BufEnter *.vim,*.nix syntax match comment "https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/" conceal cchar=>
	autocmd BufEnter * let g:mime=substitute(system('xdg-mime query filetype '..expand('%')), 'n+^', '', 'g') | let g:app=system('xdg-mime query default '..g:mime)
augroup END



