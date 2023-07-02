{pkgs, ...}: {
  # https://nixos.wiki/wiki/Maddy
  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "a@b.lt"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "test"}";
      "a@b.lt".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
  };
  # https://nixos.wiki/wiki/Maddy#Autoconfig
  # services.go-autoconfig = {
  #   enable = true;
  #   settings = {
  #     service_addr = ":1323";
  #     domain = "autoconfig.example.org";
  #     imap = {
  #       server = "example.org";
  #       port = 993;
  #     };
  #     smtp = {
  #       server = "example.org";
  #       port = 587;
  #     };
  #   };
  # };
}
