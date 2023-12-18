{
  pkgs,
  options,
  lib,
  ...
}: {
  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = lib.mkForce 40960;
  nix = {
    package = pkgs.nixFlakes;
    nixPath =
      options.nix.nixPath.default
      ++ [
        "nixpkgs-overlays=/etc/nixos/overlays/"
        # "nixos-config=/etc/nixos/configuration.nix"
      ];
    settings = {
      auto-optimise-store = true;
      substituters = [
        "http://binarycache.example.com"
        # "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
    };
    settings.allowed-users = ["@wheel" "ak"];
    settings.trusted-users = ["root" "@wheel" "ak"];
    settings.max-jobs = 4;
    settings.cores = 4;
    extraOptions = ''
      experimental-features = nix-command flakes
      # post-build-hook = /etc/nixos/post-build-hook.sh
    '';
    registry = {
      slstatus = {
        to = {
          owner = "aivarask";
          repo = "slstatus";
          type = "github";
        };
      };
      master = {
        to = {
          owner = "NixOS";
          repo = "nixpkgs";
          type = "github";
        };
      };
    };
  };
}
