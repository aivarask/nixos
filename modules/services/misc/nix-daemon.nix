{
  pkgs,
  options,
  ...
}: {
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
