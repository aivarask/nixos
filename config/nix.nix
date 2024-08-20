# NOTE: https://discourse.nixos.org/t/file-in-nix-store-empty-unable-to-be-repaired/14497/9
{ pkgs, options, ... }: {
  nix = {
    # package = pkgs.nixVersions.latest; # stable
    # nixPath = options.nix.nixPath.default ++ [ ];
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
  };
}
