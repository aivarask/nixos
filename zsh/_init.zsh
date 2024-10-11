# /run/current-system/sw/share/zsh/5.9/functions
# /run/current-system/sw/share/zsh/plugins
# /run/current-system/sw/share/zsh/site-functions
# ~/.config/zsh/.zshrc
alias \
	__fpath="print -l $fpath"

source /etc/nixos/zsh/functions.zsh
source /etc/nixos/zsh/keys.zsh
source /etc/nixos/zsh/settings.zsh

typeset -TU LUA_PATH luapath ';'
luapath+=(
	'/etc/nixos/lua/?.lua'
	'/etc/nixos/lua/?/init.lua'
	'/etc/nixos/?.lua'
	'/etc/nixos/awe/?.lua'
)

typeset -TU PATH path ':'
path+=(
	'/etc/nixos'
	'/etc/nixos/lua'
)
