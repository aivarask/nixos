{ pkgs, inputs, options, ... }: {
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
    settings.max-jobs = 3;
    settings.cores = 3;
    extraOptions = ''
      experimental-features = nix-command flakes 
      warn-dirty = false
    '';
    # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      home-manager.flake = inputs.home-manager;
      nixos = { to = { type = "git"; url = "file:///etc/nixos"; }; };
    };
  };
}
