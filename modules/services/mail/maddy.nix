{pkgs, ...}: {
  # https://nixos.wiki/wiki/Maddy
  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "postmaster@example.org"
      "test@localhost"
    ];
    ensureCredentials = {
      # Do not use this in production. This will make passwords world-readable
      # in the Nix store
      "user1@example.org".passwordFile = "${pkgs.writeText "postmaster" "test"}";
      "postmaster@example.org".passwordFile = "${pkgs.writeText "postmaster" "test"}";
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "test"}";
    };
  };
}
