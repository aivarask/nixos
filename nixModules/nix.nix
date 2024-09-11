{ pkgs, ... }: {
  environment.shellAliases = {
    nrs = "nixos-rebuild switch";
    nrt = "nixos-rebuild test";
    nrlg = "nixos-rebuild list-generations";
    nrl = "nix registry list";
    nfu = "nix flake update";
    nfl = "nix flake lock";
    ncg = "nix-collect-garbage";
  };
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
    nurl
    deadnix
    nixos-generators
    fh # flakehub
  ];
}
