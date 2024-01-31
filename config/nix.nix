{ pkgs, options, inputs, ... }: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixUnstable;
    nixPath = options.nix.nixPath.default ++ [ ];
    settings = {
      auto-optimise-store = true;
      substituters = [
        # "http://binarycache.example.com"
        # "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [ ];
    };
    settings.allowed-users = [ "@wheel" "ak" ];
    settings.trusted-users = [ "root" "@wheel" "ak" ];
    settings.max-jobs = 4;
    settings.cores = 4;
    extraOptions = ''
      keep-outputs = false
      keep-derivations = true
      experimental-features = nix-command flakes auto-allocate-uids configurable-impure-env
    '';
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      home-manager.flake = inputs.home-manager;
      snow = {
        to = { type = "path"; path = /root/snow; };
      };
      config = {
        to = { type = "path"; path = /etc/nixos; };
      };
    };
  };
}
