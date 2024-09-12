{ ... }:
{
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
			access-tokens = github.com=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
    '';

  };
}
