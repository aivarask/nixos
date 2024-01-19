{ lib, ... }: {
  networking.networkmanager = {
    enable = lib.mkDefault false;
    wifi.scanRandMacAddress = false;
    # unmanaged = [
    #   "*"
    #   "except:type:wwan"
    #   "except:type:gsm"
    # ];
  };
}
