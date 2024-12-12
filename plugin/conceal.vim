augroup mine
	autocmd!
	" https://learnvimscriptthehardway.stevelosh.com/
	" https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#pulseaudiomodules
	autocmd BufEnter *.vim,*.nix syntax match comment "https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/" conceal cchar=>
augroup END

