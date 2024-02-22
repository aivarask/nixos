source /etc/nixos/zsh/_zshmisc.zsh
source /etc/nixos/zsh/archwiki.zsh
source /etc/nixos/zsh/bindings.zsh
# source /etc/nixos/zsh/functions.zsh
source /etc/nixos/init.zsh

typeset -TU LUA_PATH luapath ';'
luapath+=(
'/etc/nixos/lua/?.lua'
'/etc/nixos/lua/?/init.lua'
'/etc/nixos/?.lua'
)

typeset -TU LUA_LIB lualib ';'
lualib+=(
'/etc/nixos/lua'
'/etc/nixos'
)

hi(){
  echo "\"hi my\""
}


