precmd() {
	print -Pn "\e]83;title \"$1\"\a"
	print -Pn "\e]0;$PWD $HOST\a"
}
preexec() {
	print -Pn "\e]83;title \"$1\"\a"
	print -Pn "\e]0;$PWD $1 $HOST\a"
}

batp() {
	echo "$1" | sed "s/:.*//" | xargs bat
}

_pack() {
	eza --oneline -d ~/pack/*/ | dmenu -l 10 | xargs -t alacritty -e 'nvim'
}

nsp() {
	nix search nixpkgs --json |
		jq -cr 'to_entries | .[] | .key |= sub("legacyPackages.x86_64-linux.";"") | .key + " | " + .value.version  + " | " + .value.description' |
		fzf --preview "nix eval nixpkgs\#{1}.meta --json | jq"
}

foo(){
	echo 'foo has arg' $1
}

# remove after :
# sed "s/:.*//"
ee() { tr -d '"' | awk '{split($0,a,":"); print a[1], "+"a[2]}' }

manixf() { manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" }

lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		if [ "$dir" != "$(pwd)" ]; then
			cd "$dir" || exit
		fi
	fi
}

lf() {
	PAGER=bat
	local tempfile
	tempfile="$(mktemp)"
	command lf -command "map Q \$echo \$PWD >$tempfile; lf -remote \"send \$id quit\"" "$@"
	if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]]; then
		cd -- "$(cat "$tempfile")" || return
	fi
	command rm -f -- "$tempfile" 2>/dev/null
}
