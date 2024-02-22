nsp() {
  nix search nixpkgs --json \
  | jq -cr 'to_entries | .[] | .key |= sub("legacyPackages.x86_64-linux.";"") | .key + " | " + .value.version  + " | " + .value.description' \
  | fzf --preview "nix eval nixpkgs\#{1}.meta --json | jq"
}

