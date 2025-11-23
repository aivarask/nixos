{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nixd
    nil
    nurl
    deadnix
    fh
    nix-tree
    nixos-generators
  ];
  environment.shellAliases.nrs = "nixos-rebuild switch";
  environment.shellAliases.nfu = "nix flake update";
  # export NIXPKGS_ALLOW_INSECURE=1

  # nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.flake.setNixPath = true;

  nix.optimise.automatic = true;
  # nix.package = pkgs.nixVersions.latest; # stable
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 1w";
  nix.channel.enable = false;
  nix.registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
  nix.nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  nix.extraOptions = ''
    use-xdg-base-directories = true
    warn-dirty = false
    download-buffer-size = ${toString (67108864 * 4)}
  '';
  nix.settings.max-jobs = 8;
  nix.settings.cores = 4;
  nix.settings.auto-optimise-store = true;
  nix.settings.substituters = lib.mkForce [
    # "http://binarycache.dell.local"
    "https://nix-community.cachix.org"
    "https://cache.nixos.org/"
    "https://hyprland.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "binarycache.dell.local:qsxxQz/7dy2UdmrbBLAsx8JDjExnQkCDmi2lF2m2OiE="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
  nix.settings.experimental-features = "nix-command flakes pipe-operators";
  nix.settings.flake-registry = "";
  nix.settings.nix-path = config.nix.nixPath; # Workaround for https://github.com/NixOS/nix/issues/9574
  # required, otherwise remote buildMachines above aren't used
  nix.distributedBuilds = true;
  # optional, useful when the builder has a faster internet connection than yours
  nix.settings.builders-use-substitutes = true;

}
