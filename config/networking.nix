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
  systemd.network.enable = true;
  services.resolved.enable = true;
  networking = {
    useNetworkd = true;
    firewall.enable = true;
    nameservers = [
      # "1.1.1.1"
      "127.0.0.1"
      "::1"
    ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.dns = "none";
  };
  networking.resolvconf.useLocalResolver = true;
  networking.hosts."192.168.1.195" = [ "pcw" ];
}
