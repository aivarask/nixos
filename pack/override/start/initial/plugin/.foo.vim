" https://devhints.io/vimscript
nnoremap <Space>c :messages clear<CR>
" let [f, l] = system("source /etc/nixos/zsh/main.zsh; move")

" go go-org goo go-not-exist
let p = expand("<cword>")
let o = system("nix eval nixpkgs\#" . p . '.meta.position')
if !v:shell_error
  let [f, l] = o->substitute("\\n", "", "g")->substitute("\"", "", "g")->split(":")
  execute 'edit ' f | execute "normal " .. l .. "G"
else
  echomsg o
endif

