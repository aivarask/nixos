{ pkgs, ... }: {
  environment.shellAliases = {
    ncl = "nix-channel --list";
    ncu = "nix-channel --update";
    nr = "nixos-rebuild";
    nrs = "nixos-rebuild switch";
    nrt = "nixos-rebuild test";
    nrl = "nix registry list";
    nfu = "nix flake update";
    nfl = "nix flake lock";
  };
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    nil
    nurl
    deadnix
    nixd
    nixos-generators
    nix-index
  ];
}
