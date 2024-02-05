{ lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
    remote-touchpad
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
    nameservers = [ "127.0.0.1" "::1" ];
    dhcpcd.extraConfig = "nohook resolv.conf"; # /etc/nixos/config/services/dnscrypt-proxy2.nix
    useNetworkd = true;
    hosts = {
      "192.168.1.1" = [ "hw.local" ];
      # --
      "127.0.0.1" = [
        "live.fixasparts.com"
        "example.com"
        # "binarycache.example.com"
      ];
      "192.168.1.190" = [ "pcl" "pcl.local" ];
      "192.168.1.195" = [ "pcw" "pcw.local" ];
      "192.168.1.180" = [ "dell" "dell.local" ];
      "192.168.1.170" = [ "i7" "i7.local" ];
      "192.168.1.150" = [ "a5" "a5.local" ];
      "188.69.243.169" = [ "namai" "namai.local" ];
      "195.181.244.248" = [ "q0nr.l.dedikuoti.lt" "fixas" "new.fixasparts.com" ];
    };
    extraHosts = ''
      127.0.0.2 other-localhost
      10.0.0.1 server
      127.0.0.1 live.fixasparts.com
    '';
    firewall.enable = true;
    firewall.allowedTCPPorts = [
      80 # http
      443 # https
      9000 # remote-touchpad
    ];
  };
  networking.wireless = {
    enable = lib.mkDefault true;
    userControlled = {
      enable = true;
      group = "wheel";
    };
    networks = {
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
      hw = {
        # psk = "laikinas";
        pskRaw = "4ac51a255791c6ec52af3fd3f09cf6d9412f9305156d2d38f81798aec41eeb8f";
      };
      zte = {
        # psk = "laikinas";
        pskRaw = "af597066be5a0c334db3681bf8a490fd25da82824f4984b4bfa6c18d60a3aa16";
      };
      "Aivaras's iPhone" = {
        psk = "laikinas";
        # pskRaw = "6fa09f66ff2c9a00eb98e22eb55048179a9c1fea981976ca9d228273160a98c8";
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
