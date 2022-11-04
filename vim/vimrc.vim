let &runtimepath.=','.'/etc/nixos/vim'

aug Initial
  au!
  au BufWritePost vimrc :so %
  autocmd BufEnter *.postcss setlocal ft=css
  autocmd VimResized * wincmd =
  " autocmd VimResized * FloatermUpdate
  " https://vim.fandom.com/wiki/Multiple_commands_at_once
  au BufWritePost schema.prisma :execute 'silent! !prisma generate' | :LspRestart
aug END

source /etc/nixos/vim/keymaps.vim 
source /etc/nixos/vim/settings.vim 

if has('termguicolors')
  set termguicolors
endif
set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'mix'
" NOTE: Not working due to secured derivation path
" Not needed btw
" let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material
