{ config, pkgs, lib, options, ... }: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      # https://github.com/nix-community/nix-direnv#via-home-manager
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixUnstable;
    # package = pkgs.nixFlakes; # 21.11 maybe
    # maxJobs = lib.mkDefault 24;
    settings.auto-optimise-store = true; # nix-store --optimise This is a potentially long operation. 
    settings.allowed-users = [ "@wheel" "ak" ];
    settings.trusted-users = [ "root" "@wheel" "ak" ];
    settings.max-jobs = 4; # https://nixos.org/manual/nix/stable/advanced-topics/cores-vs-jobs.html
    settings.cores = 4;
  };
  nix.nixPath =
    # Prepend default nixPath values.
    options.nix.nixPath.default ++
    # Append our nixpkgs-overlays.
    [ "nixpkgs-overlays=/etc/nixos/overlays/" ]
  ;
}

