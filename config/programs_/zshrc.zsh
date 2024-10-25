autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
autoload -Uz run-help-git run-help-nix run-help-ip run-help-openssl run-help-sudo

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

precmd() {
	print -Pn "\e]83;title \"$1\"\a"
	print -Pn "\e]0;$PWD $HOST\a"
}
preexec() {
	print -Pn "\e]83;title \"$1\"\a"
	print -Pn "\e]0;$PWD $1 $HOST\a"
}
manixf() { manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" }

lf() {
	PAGER=bat
	export LF_CD_FILE="/var/tmp/.lfcd-$$"
	command lf "$@"
	if [ -s "$LF_CD_FILE" ]; then
		local DIR="$(realpath -- "$(cat -- "$LF_CD_FILE")")"
		if [ "$DIR" != "$PWD" ]; then
			printf 'cd to %s\n' "$DIR"
			cd "$DIR"
		fi
		rm "$LF_CD_FILE"
	fi
	unset LF_CD_FILE
}

bindkey '^[[Z' reverse-menu-complete # S-Tab
bindkey '^ ' forward-word            # C-Space
bindkey '^[[1;5C' autosuggest-accept # C-Right
bindkey '^[[3;5~' kill-word          # C-Del
bindkey "^[OP" "run-help"            # <F1>
bindkey -s "^[OQ" "manixf\n"         # <F2>
bindkey -s "^[[15~" "exec zsh\n"     # <F5>
bindkey -s "^F" "fzf -m\n"
bindkey -s "^G" "Rg\n"

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

alias lazygit='lazygit -ucf /etc/nixos/config/files/lazygit.yml'
alias \\l='lazygit'
