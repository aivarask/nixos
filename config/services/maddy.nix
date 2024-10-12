{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Maddy
  # https://nixos.wiki/wiki/Maddy#Autoconfig
  networking.firewall.allowedTCPPorts = [
    993
    465
  ];
  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "ab@localhost"
      "test@test.ekolangas.lt"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "ab@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "test@test.ekolangas.lt".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
  };
}
