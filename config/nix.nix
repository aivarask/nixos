{
  pkgs,
  options,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nix-doc
  ];
  nix = {
    # https://mynixos.com/nixpkgs/options/nix.registry.%3Cname%3E
    registry = {
      # https://github.com/aivarask/slstatus/blob/master/flake.nix
      slstatus = {
        to = {
          owner = "aivarask";
          repo = "slstatus";
          type = "github";
        };
      };
      # https://github.com/NixOS/nixpkgs/blob/master/flake.nix
      master = {
        to = {
          owner = "NixOS";
          repo = "nixpkgs";
          type = "github";
        };
      };
      # stable = {
      #   to = {
      #     owner = "NixOS";
      #     repo = "nixpkgs";
      #     type = "github";
      #   };
      #   from = {
      #     id = "nixpkgs";
      #     type = "indirect";
      #   };
      # };
    };
    extraOptions = ''
      # plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
      experimental-features = nix-command flakes
      # https://github.com/nix-community/nix-direnv#via-home-manager
      # keep-outputs = true
      # keep-derivations = true
      # NOTE: nix-daemon executes following, which is available in nix-darwin
      # post-build-hook = /etc/nixos/post-build-hook.sh
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    # package = pkgs.nixUnstable;
    package = pkgs.nixFlakes;
    settings = {
      auto-optimise-store = true;
    };
    settings.allowed-users = ["@wheel" "ak"];
    settings.trusted-users = ["root" "@wheel" "ak"];
    settings.max-jobs = 4;
    settings.cores = 4;

    nixPath =
      options.nix.nixPath.default
      ++ [
        "nixpkgs-overlays=/etc/nixos/overlays/"
        # "nixos-config=/etc/nixos/configuration.nix"
      ];
  };
}
