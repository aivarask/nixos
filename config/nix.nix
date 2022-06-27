{ config, pkgs, lib, ... }: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      # https://github.com/nix-community/nix-direnv#via-home-manager
      # keep-outputs = true
      # keep-derivations = true
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
  };
}

