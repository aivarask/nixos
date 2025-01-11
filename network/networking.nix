# https://nixos.wiki/wiki/Encrypted_DNS
# https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Configuration
# https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
# https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ookla-speedtest
    curlFull
    httpie
    tcpdump
    tcpflow
    lftp
    ethtool
    wol
    bind
    drill
    dig
    dnsx
    geoipWithDatabase
    mkcert
    nmap
    wget
    whois
    inetutils
    openssl
    nss
    socat
    websocat
    websocketd
  ];
  programs.bandwhich.enable = true;
  programs.iftop.enable = true;
  programs.sharing.enable = true;
  programs.mtr.enable = true;
  programs.wireshark.enable = true;
  # https://nixos.wiki/wiki/Systemd-networkd
  systemd.network.enable = true;
  networking = {
    useNetworkd = true;
    resolvconf.useLocalResolver = true;
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    firewall = {
      enable = true;
      extraCommands = ''
        ip6tables --table nat --flush OUTPUT
        ${lib.flip (lib.concatMapStringsSep "\n")
          [
            "udp"
            "tcp"
          ]
          (proto: ''
            ip6tables --table nat --append OUTPUT \
              --protocol ${proto} --destination ::1 --destination-port 53 \
              --jump REDIRECT --to-ports 51
          '')
        }
      '';
    };
  };
  services.resolved.enable = false;
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
}
