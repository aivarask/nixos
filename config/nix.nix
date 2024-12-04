{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nixd
    nil
    nurl
    deadnix
    nixos-generators
    fh # flakehub
  ];
  environment.shellAliases.nrs = "nixos-rebuild switch";
  environment.shellAliases.nfu = "nix flake update";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.flake.setNixPath = true;

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      # package = pkgs.nixVersions.latest; # stable
      # nixPath = options.nix.nixPath.default ++ [ ];
      # nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
      settings = {
        max-jobs = 8;
        cores = 4;
        auto-optimise-store = false;
        substituters = [
          "https://hyprland.cachix.org"
          "https://cache.nixos.org/"
        ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        ## https://discourse.nixos.org/t/why-is-an-older-version-of-an-app-getting-installed-here/49413/6
        ## https://github.com/Misterio77/nix-starter-configs/blob/cd2634edb7742a5b4bbf6520a2403c22be7013c6/standard/nixos/configuration.nix
        ## https://jade.fyi/blog/pinning-nixos-with-npins/
        ## https://github.com/infinisil/sanix?tab=readme-ov-file
        ## https://dotfiles.cgdct.moe/nix/nixos/#removing-channels-and-flake-registries
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      extraOptions = ''
        warn-dirty = false
      '';
    };

}
