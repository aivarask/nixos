{ pkgs, ... }:
{
  environment.shellAliases = {
    nrs = "nixos-rebuild switch";
    nfu = "nix flake update";
    ncg = "nix-collect-garbage";
  };
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nixd
    nil
    nurl
    deadnix
    nixos-generators
    fh # flakehub
  ];
}
