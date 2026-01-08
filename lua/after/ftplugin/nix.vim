ia <buffer> m@ { pkgs, lib, config, SELF, ... }: {<CR><CR>}<Up>
ia <buffer> (m@ ()<Left>m@<Space>
"home-manager
ia <buffer> ln@ config.lib.file.mkOutOfStoreSymlink
ia <buffer> sc@ "${SELF}/.config/"<Left><Left>

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

