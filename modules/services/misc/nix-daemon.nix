{ pkgs
, options
, lib
, ...
}: {
  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = lib.mkForce 40960;
  # https://aldoborrero.com/posts/2022/12/02/learn-how-to-use-the-nix-repl-effectively/
  # https://nixos.org/manual/nix/stable/command-ref/env-common
  # https://nixos.org/manual/nix/stable/command-ref/files/profiles
  # https://nixos.org/manual/nix/stable/command-ref/files/channels
  nix = {
    package = pkgs.nixUnstable;
    nixPath =
      options.nix.nixPath.default
      ++ [
        # <<< defaults
        # "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
        # "nixos-config=/etc/nixos/configuration.nix"
        # "/nix/var/nix/profiles/per-user/root/channels"
        # >>>
        "nixpkgs-overlays=/etc/nixos/overlays/"
      ];
    settings = {
      auto-optimise-store = true;
      substituters = [
        # "http://binarycache.example.com"
        # "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
    };
    settings.allowed-users = [ "@wheel" "ak" ];
    settings.trusted-users = [ "root" "@wheel" "ak" ];
    settings.max-jobs = 4;
    settings.cores = 4;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-experimental-features = auto-allocate-uids configurable-impure-env
      keep-derivations = true
      keep-outputs = false
      # post-build-hook = /etc/nixos/post-build-hook.sh
    '';
    registry = {
      # nix registry list
      # https://github.com/NixOS/flake-registry
      hm = {
        to = {
          owner = "nix-community";
          repo = "home-manager";
          type = "github";
        };
      };
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
