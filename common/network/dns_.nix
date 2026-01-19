{ ... }:
{
  services.privoxy.enable = false;
  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.configFile = "/etc/nixos/network/dnscrypt-proxy.toml";
  systemd.services.dnscrypt-proxy2.wants = [ "network-online.target" ];
  systemd.services.dnscrypt-proxy2.after = [ "network-online.target" ];
  systemd.services.dnscrypt-proxy2.wantedBy = [ "multi-user.target" ];
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    User = "root";
    StateDirectory = "dnscrypt-proxy";
    PermissionsStartOnly = "true";
    RestartSec = "2s";
  };
}
