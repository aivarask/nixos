{ ... }:
let
  include = p: with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
in
{
  imports =
    [
      ./systemPackages
    ]
    # ++ include ./systemPackages
    ++ include ./plugin
    ++ (import ./modules/module-list.nix);
}
