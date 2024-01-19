{ ... }: {
  # nix-collect-garbage --delete-old
  # https://nixos.org/manual/nix/unstable/package-management/garbage-collection.html
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
