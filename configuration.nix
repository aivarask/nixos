{ pkgs, ... }:
let
  include = p: with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
in
{
  imports = [ ]
    ++ include ./spackages
    ++ include ./plugin
    ++ (import ./modules/module-list.nix);

  environment.shellAliases = {
    nr = "nixos-rebuild";
    nrs = "nixos-rebuild switch";
    nrt = "nixos-rebuild test";
    nfu = "nix flake update";
    nfl = "nix flake lock";
  };

  # https://nixos.org/manual/nixpkgs/unstable/#vim
  environment.systemPackages = with pkgs; [
    vim
  ];
}
