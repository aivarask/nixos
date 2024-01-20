let
  include = p: with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
in
rec {
  # config = with builtins; dirOf (findFile nixPath "nixos-config");
  res = include ./plugin;
}

