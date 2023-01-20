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
      auto-optimise-store =
        true; # nix-store --optimise This is a potentially long operation.
    };
    settings.allowed-users = [ "@wheel" "ak" ];
    settings.trusted-users = [ "root" "@wheel" "ak" ];
    settings.max-jobs =
      4; # https://nixos.org/manual/nix/stable/advanced-topics/cores-vs-jobs.html
    settings.cores = 4;

    nixPath =
      # NIX_PATH
      options.nix.nixPath.default
      ++
      # Append our nixpkgs-overlays.
      [
        # "nixpkgs-overlays=/etc/nixos/overlays/"
        # "nixos-config=/etc/nixos/configuration.nix"
      ];
  };
}
