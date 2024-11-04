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
  networking = {
    useNetworkd = true;
    firewall.enable = true;
    nameservers = [
      "1.1.1.1"
      "127.0.0.1"
      "::1"
    ];
    extraHosts = ''
      127.0.0.2 localhost2
      10.0.0.1 server
    '';
  };
  networking.hosts = {
    "192.168.1.1" = [
      "hw"
      "hw.local"
    ];
    "192.168.1.195" = [
      "pcw"
      "pcw.local"
    ];
    "192.168.1.180" = [
      "dell"
      "dell.local"
    ];
  };
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      forwarding_rules = "/etc/nixos/config/networking.rules";
      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
      ipv6_servers = false;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];
    };
  };
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
  networking.wireless = {
    enable = lib.mkDefault true;
    userControlled = {
      enable = true;
      group = "wheel";
    };
    networks = {
      hw = {
        pskRaw = "4ac51a255791c6ec52af3fd3f09cf6d9412f9305156d2d38f81798aec41eeb8f";
      };
      "Laisvas Internetas_FC7A" = {
        #psk="laisvas123"
        pskRaw = "4d367689b1b912bc7a678673ff1944f8c1dc5b4188ce2346bf50572034be66eb";
        authProtocols = [
          "WPA-PSK"
          "WPA-EAP"
          "IEEE8021X"
          "WPA-PSK-SHA256"
        ];
      };
      Zyxel_AFB1 = {
        #psk = "MDGEJ8GL43"
        pskRaw = "8b82fcb0266936dfeb98720b4256bb22879b863f3679f8d2781c0e3c142d4cae";
        authProtocols = [
          "WPA-PSK"
          "WPA-EAP"
          "IEEE8021X"
          "WPA-PSK-SHA256"
        ];
      };
    };
  };
}
