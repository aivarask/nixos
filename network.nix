{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffuf
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
  # netstat -antup
  # nestat --all --numeric --tcp --udp --program
  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
    "192.168.0.1"
  ];
  programs.bandwhich.enable = true;
  programs.iftop.enable = true;
  programs.sharing.enable = true;
  programs.mtr.enable = true;
  programs.wireshark.enable = true;
}
