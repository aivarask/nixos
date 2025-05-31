{ ... }:
{
  services.dnscrypt-proxy2 = {
    enable = true;
    configFile = "/etc/nixos/network/dnscrypt-proxy.toml";
  };
  systemd.services.dnscrypt-proxy2 = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "root";
      StateDirectory = "dnscrypt-proxy";
      PermissionsStartOnly = "true";
      RestartSec = "2s";
    };
  };
  services.privoxy = {
    enable = false;
  };
}
