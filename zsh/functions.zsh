foo() {
	echo 'im function' $1
}

nsp() {
	nix search nixpkgs --json |
		jq -cr 'to_entries | .[] | .key |= sub("legacyPackages.x86_64-linux.";"") | .key + " | " + .value.version  + " | " + .value.description' |
		fzf --preview "nix eval nixpkgs\#{1}.meta --json | jq"
}

# remove after :
# sed "s/:.*//"
ee() {
	tr -d '"' | awk '{split($0,a,":"); print a[1], "+"a[2]}'
}
