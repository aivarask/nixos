{ lib, ... }:
{
  services.blueman = {
    # Device B8:53:AC:C2:7F:24 Aivaras’s iPhone
    # Device AC:90:85:C6:DA:FD AirPods
    # Device D4:11:A3:98:B4:88 Galaxy A50
    enable = lib.mkDefault false;
  };
}
