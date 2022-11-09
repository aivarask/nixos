let &runtimepath.=','.'/etc/nixos/vim'

function Name() abort
  " :FloatermToggle()
  :FloatermNew --wintype=vsplit --width=0.4 --autoclose=1 neofetch
endfunction

function Schema() abort
  :FloatermNew --wintype=vsplit --width=0.4 --autoclose=1 prisma db push
  :LspRestart
endfunction

aug Initial
  au!
  au BufWritePost vimrc :so %
  autocmd BufEnter *.postcss setlocal ft=css
  autocmd VimResized * wincmd =
  " autocmd VimResized * FloatermUpdate
  " https://vim.fandom.com/wiki/Multiple_commands_at_once
  " au BufWritePost schema.prisma :execute 'silent! !prisma generate' | :execute '!prisma db push' | :LspRestart
  " au BufWritePost schema.prisma :terminal 'prisma db push' | :LspRestart
  " au BufWritePost schema.prisma :execute ':terminal prisma db push' 
  " au BufWritePost schema.prisma :terminal prisma db push
  " au BufWritePost schema.prisma :executae 'silent! :terminal prisma db push' 
  " au BufWritePost vimrc.vim :call Name() | LspRestart
  " INFO: https://stackoverflow.com/questions/3249275/multiple-commands-on-same-line
  au BufWritePost schema.prisma :call Schema() 
aug END

source /etc/nixos/vim/keymaps.vim 
source /etc/nixos/vim/settings.vim 

set background=dark
if has('nvim')
  if has('termguicolors')
    set termguicolors
    let g:gruvbox_material_background = 'medium'
    let g:gruvbox_material_foreground = 'mix'
    " NOTE: Not working due to secured derivation path
    " Not needed btw
    " let g:gruvbox_material_better_performance = 1
  endif

  colorscheme gruvbox-material
else
  colorscheme gruvbox-material
endif

