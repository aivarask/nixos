{ lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wpa_gui
  ];
  networking.wireless = {
    enable = lib.mkDefault true;
    userControlled.enable = true;
    userControlled.group = "network";
    networks = {
      hw = {
        pskRaw = "4ac51a255791c6ec52af3fd3f09cf6d9412f9305156d2d38f81798aec41eeb8f";
      };
      "Laisvas Internetas_FC7A" = {
        pskRaw = "4d367689b1b912bc7a678673ff1944f8c1dc5b4188ce2346bf50572034be66eb";
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
