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
  };
  networking.wireless.networks.hw = {
    # psk = "laikinas";
    pskRaw = "4ac51a255791c6ec52af3fd3f09cf6d9412f9305156d2d38f81798aec41eeb8f";
  };
}
