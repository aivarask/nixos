{ pkgs, inputs, ... }:
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
  nix = {
    # package = pkgs.nixVersions.latest; # stable
    # nixPath = options.nix.nixPath.default ++ [ ];
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = true;
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
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [ ];
    };
    extraOptions = ''
      warn-dirty = false
      experimental-features = nix-command flakes
    '';
    # access-tokens = github.com=
    # gh auth token
    registry = {
      os = {
        to = {
          type = "git";
          url = "file:///etc/nixos";
        };
      };
      "dev-templates" = {
        to = {
          owner = "the-nix-way";
          repo = "dev-templates";
          type = "github";
        };
      };
    };
  };

}
