source /etc/nixos/zsh/_zshmisc.zsh
source /etc/nixos/zsh/archwiki.zsh
source /etc/nixos/zsh/bindings.zsh
# source /etc/nixos/zsh/functions.zsh

typeset -TU LUA_PATH luapath ';'
luapath+=(
'/etc/nixos/vim/lua/?.lua'
'/etc/nixos/vim/lua/?/init.lua'
'/etc/nixos/vim/?.lua'
'/root/hoo/?.lua' 
)

typeset -TU LUA_LIB lualib ';'
lualib+=(
'/etc/nixos/vim/lua'
'/etc/nixos/vim'
'/root/hoo'
)

hi(){
  echo "\"hi my\""
}

edit() {
  echo '"foo.vim:3"'
}

foo() {
  echo $1
  return 2
}

move() {
mv foo bar
}
