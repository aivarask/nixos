{ pkgs, inputs, options, ... }: {
  nix = {
    channel.enable = false;
    # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
    # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
    # environment.etc."nix/inputs/nixpkgs".source = "${pkgs}";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2w";
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
    settings.max-jobs = 2;
    settings.cores = 4;
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
