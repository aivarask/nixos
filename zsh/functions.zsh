nsp() {
	nix search nixpkgs --json |
		jq -cr 'to_entries | .[] | .key |= sub("legacyPackages.x86_64-linux.";"") | .key + " | " + .value.version  + " | " + .value.description' |
		fzf --preview "nix eval nixpkgs\#{1}.meta --json | jq"
}

# remove after :
# sed "s/:.*//"
ee() { tr -d '"' | awk '{split($0,a,":"); print a[1], "+"a[2]}' }

mx() { manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" }

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
