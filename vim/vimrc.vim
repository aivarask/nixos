let &runtimepath.=','.'/etc/nixos/vim'
" .','.'/root/luamodules'

aug Initial
	au!
	au BufWritePost vimrc :so %
	autocmd VimResized * wincmd =
  autocmd VimResized * FloatermUpdate
  " https://vim.fandom.com/wiki/Multiple_commands_at_once
  au BufWritePost schema.prisma :execute 'silent! !pg' | :LspRestart
aug END

source /etc/nixos/vim/keymaps.vim 
source /etc/nixos/vim/settings.vim 

set background=dark
if has('nvim')
	colorscheme gruvbox-material
else
	colorscheme gruvbox8
endif


