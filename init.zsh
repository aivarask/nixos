nsp() {
    nix search nixpkgs --json \
        | jq -cr 'to_entries | .[] | .key |= sub("legacyPackages.x86_64-linux.";"") | .key + " | " + .value.version  + " | " + .value.description' \
        | fzf --preview "nix eval nixpkgs\#{1}.meta --json | jq"
}


foo() {
    echo "$1" | sed "s/:.*//" | xargs nvim -
}

zoo() {
    # echo "$1"
    echo "$1" | sed "s/:.*//" | nvim -
}

hi() {
    echo '/etc/nixos/vimrc.vim' | xargs nvim
}
