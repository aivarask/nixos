{ lib, pkgs, ... }: {
  environment.shellAliases = {
    nr = "nixos-rebuild";
    nrs = "nixos-rebuild switch";
    nrt = "nixos-rebuild test";
    nrlg = "nixos-rebuild list-generations";
    nrl = "nix registry list";
    nfc = "nix flake check"; # duplicates with nfc
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
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.permittedInsecurePackages = [ ];
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # audio
      "vital"
      "vital-1.5.5"
      "bitwig-studio"
      # --
      "unrar"
      "soulseekqt"
      "google-chrome"
      "google-chrome-dev"
      "nvidia-x11"
      "nvidia-settings"
      "ookla-speedtest"
      "vscode"
      "intelephense"
    ];
}
