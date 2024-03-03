# source /etc/nixos/initfzf.zsh
# source /etc/nixos/initlf.zsh
source /etc/nixos/initkeys.zsh
source /etc/nixos/initset.zsh

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

nsp() {
    nix search nixpkgs --json \
        | jq -cr 'to_entries | .[] | .key |= sub("legacyPackages.x86_64-linux.";"") | .key + " | " + .value.version  + " | " + .value.description' \
        | fzf --preview "nix eval nixpkgs\#{1}.meta --json | jq"
}

# remove after :
# sed "s/:.*//"

ee() {
    tr -d '"' | awk '{split($0,a,":"); print a[1], "+"a[2]}'
}

# /run/current-system/sw/share/zsh/5.9/functions
# /run/current-system/sw/share/zsh/plugins
# /run/current-system/sw/share/zsh/site-functions
# ~/.config/zsh/.zshrc
# ./zsh/_bcomp.zsh
# ./zsh/_comp.zsh


alias af="alias | fzf" \
    __fpath="print -l $fpath" \
    gr=foo \
    ci=compinit

# ./bin/foo
foo() {
    echo 'im function' $1
}
