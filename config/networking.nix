{ lib, pkgs, ... }: {
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
  networking.networkmanager = {
    enable = lib.mkDefault false;
    wifi.scanRandMacAddress = false;
    # unmanaged = [
    #   "*"
    #   "except:type:wwan"
    #   "except:type:gsm"
    # ];
  };
  networking = {
    useNetworkd = true;
    firewall.enable = true;
    dhcpcd.extraConfig = "nohook resolv.conf"; # /etc/nixos/config/services/dnscrypt-proxy2.nix
    nameservers = [ "127.0.0.1" "::1" ];
    hosts = {
      "127.0.0.1" = [ "local.local" ];
      "192.168.1.1" = [ "hw" "hw.local" ];
      "192.168.1.190" = [ "pcl" "pcl.local" ];
      "192.168.1.195" = [ "pcw" "pcw.local" ];
      "192.168.1.180" = [ "dell" "dell.local" ];
      "192.168.1.170" = [ "i7" "i7.local" ];
      "192.168.1.150" = [ "a5" "a5.local" ];
      "192.168.1.127" = [ "redmi" "redmi.local" ];
    };
    extraHosts = ''
      127.0.0.2 localhost2
      10.0.0.1 server
    '';
  };
}
