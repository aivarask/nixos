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
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    hosts = {
      "127.0.0.1" = [ "local.local" ];
      "192.168.1.1" = [
        "hw"
        "hw.local"
      ];
      "192.168.1.190" = [
        "pcl"
        "pcl.local"
      ];
      "192.168.1.195" = [
        "pcw"
        "pcw.local"
      ];
      "192.168.1.180" = [
        "dell"
        "dell.local"
      ];
      "192.168.1.170" = [
        "i7"
        "i7.local"
      ];
      "192.168.1.150" = [
        "a5"
        "a5.local"
      ];
      "192.168.1.127" = [
        "redmi"
        "redmi.local"
      ];
    };
    extraHosts = ''
      127.0.0.2 localhost2
      10.0.0.1 server
    '';
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
