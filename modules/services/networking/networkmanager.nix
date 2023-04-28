_: {
  networking.networkmanager = {
    enable = false;
    wifi.scanRandMacAddress = false;
    unmanaged = [
      "*"
      "except:type:wwan"
      "except:type:gsm"
    ];
  };
}
