# https://nixos.wiki/wiki/Encrypted_DNS
# https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
# https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
  # https://nixos.wiki/wiki/Systemd-networkd

  networking = {
    resolvconf.useLocalResolver = true;
    useNetworkd = true;
    firewall.enable = true;
    nameservers = [ "::1" ];
  };
  services.resolved = {
    enable = false;
  };
  systemd.network.enable = true;
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
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      listen_addresses = [ "[::1]:51" ];
      # forwarding_rules = "/etc/nixos/dnscrypt-proxy2/forwarding-rules.txt";
      cloaking_rules = "/etc/nixos/dnscrypt-proxy2/cloaking-rules.txt";
      ipv6_servers = false;
      block_ipv6 = true;
      # require_dnssec = true;
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/etc/nixos/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
      server_names = [ "a-and-a" ];
    };
  };
  networking.firewall.extraCommands = ''
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

}
