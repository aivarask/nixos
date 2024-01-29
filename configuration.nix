{ pkgs, ... }:
let
  include = p: with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
in
{
  imports = [
    # ./paging.nix
  ]

  ++ include ./config
  ++ include ./config/environment
  ++ include ./config/services
  ++ include ./config/systemd
  ++ include ./spackages
  ++ include ./plugin
  ;

  environment.shellAliases = {
    tilda = "tilda -g /etc/nixos/tilda";
  };

  # https://nixos.org/manual/nixpkgs/unstable/#vim
  environment.systemPackages = with pkgs; [
    vim
  ];
}
