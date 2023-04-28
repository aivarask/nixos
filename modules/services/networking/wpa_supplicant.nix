_: {
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
