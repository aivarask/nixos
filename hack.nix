rec {
  config = with builtins; dirOf (findFile nixPath "nixos-config");
}

