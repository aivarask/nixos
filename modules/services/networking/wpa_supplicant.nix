{ lib, ... }: {
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
