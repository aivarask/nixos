{ pkgs
, options
, ...
}: {
  environment.systemPackages = with pkgs; [
    nix-doc
  ];
  nix = {
    extraOptions = ''
      plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
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
    # package = pkgs.nixUnstable;
    package = pkgs.nixFlakes; # 21.11 maybe
    # maxJobs = lib.mkDefault 24;
    settings = {
      auto-optimise-store = true;
    };
    settings.allowed-users = [ "@wheel" "ak" ];
    settings.trusted-users = [ "root" "@wheel" "ak" ];
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
