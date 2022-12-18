{ config, ... }: {
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
    };
  };
}
