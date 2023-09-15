{...}: {
  # nix-collect-garbage --delete-old
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
