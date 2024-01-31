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
    ncg = "nix-collect-garbage";
  };
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    nil
    nurl
    deadnix
    nixos-generators
  ];
}
