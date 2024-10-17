rec {
  include =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*+\.nix" n)) (attrNames (readDir p)));
  nixWillInclude = include ./.;
  includeHome =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.]+.*+\.nix" n)) (attrNames (readDir p)));
  homeIncludes = includeHome ./.;
}
