fpath=(/etc/nixos/zfunc $fpath);
setopt extended_glob; autoload -U $fpath[1]/**/*(.:t)
# source $(dirname $0)/zhooks.zsh

autoload -Uz edit-command-line; zle -N edit-command-line; bindkey '\ev' edit-command-line
autoload -Uz run-help run-help-git run-help-nix run-help-ip run-help-openssl run-help-sudo
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

alias nf='nixos-rebuild switch --fast'
alias tmux_lf='tmux split -h lf; lf'
alias lazygit='lazygit -ucf /etc/nixos/config/files/lazygit.yml'
alias \\l='lazygit'
export NCMPCPP_CONFIG=/etc/nixos/config/files/ncmpcpp_config
export NCMPCPP_BINDINGS=/etc/nixos/config/files/ncmpcpp_bindings
alias ncmpcpp_='ncmpcpp -c $NCMPCPP_CONFIG -b $NCMPCPP_BINDINGS'

bindkey '^[[Z' reverse-menu-complete # S-Tab
bindkey '^ ' forward-word            # C-Space
bindkey '^[[1;5C' autosuggest-accept # C-Right
bindkey '^[[3;5~' kill-word          # C-Del
bindkey "^[OP" "run-help"            # <F1>
bindkey -s "^[OQ" "manix_fzf\n"      # <F2>
bindkey -s "^F" "fzf -m\n"
bindkey -s "^G" "Rg\n"

typeset -TU LUA_PATH luapath ';'
luapath+=(
	'/etc/nixos/lua/?.lua'
)
export LUA_PATH

typeset -TU PATH path ':'
path+=(
	'/etc/nixos'
	'/etc/nixos/lua'
)

