{ pkgs, ... }:
let
  include = p: with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
in
{
  imports = [
    # ./paging.nix
  ]
  ++ include ./spackages
  ++ include ./plugin
  ++ (import ./modules/module-list.nix);

  environment.shellAliases = { };

  # https://nixos.org/manual/nixpkgs/unstable/#vim
  environment.systemPackages = with pkgs; [
    vim
  ];

}
