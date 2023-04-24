_: {
  networking = {
    hosts = {
      "127.0.0.1" = ["live.fixasparts.com"];
      "192.168.1.1" = ["hw.lan"];
      "192.168.1.110" = ["pcl"];
      "192.168.1.111" = ["pc"];
      "192.168.1.120" = ["dell"];
      "188.69.243.169" = [
      ];
      "195.181.244.248" = ["q0nr.l.dedikuoti.lt" "fixas" "new.fixasparts.com"];
    };
    extraHosts = ''
      127.0.0.2 other-localhost
      10.0.0.1 server
      88.80.28.163 linkomanija.net
      127.0.0.1 live.fixasparts.com
      127.0.0.1 test.com
    '';

    nameservers = [
      # "127.0.0.1" # localhost
      # "192.168.1.1" # router
      "1.1.1.1" # Cloudflare
      # "8.8.8.8" # Google
      # "8.8.4.4" # Google2
    ];
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    3000
    3306
    4173
    5173
    5434
    9000
    9100
  ];

  networking.networkmanager = {
    enable = false;
    wifi.scanRandMacAddress = false;
    unmanaged = [
      "*"
      "except:type:wwan"
      "except:type:gsm"
    ];
  };

  networking.wireless = {
    enable = true;
    userControlled = {
      enable = true;
      group = "wheel";
    };
    networks = {
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
