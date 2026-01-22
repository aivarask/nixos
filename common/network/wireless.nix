{ lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wpa_supplicant_gui
  ];
  networking.wireless.enable = lib.mkDefault true;
  networking.wireless.userControlled = true;
  networking.wireless.networks."aivarask" = {
    priority = 1;
    pskRaw = "79bafe618e78aa0113e5d8c1000bd6d68705f96f011aeb066d355900cafb4ec3";
  };
  networking.wireless.networks.hw5 = {
    priority = 2;
    pskRaw = "eb63cd4462ef280ce3fec88a3fd991d770e97824911cc953d1e64aea2ca35289";
  };
  networking.wireless.networks.hw = {
    priority = 3;
    psk = "laikinas";
    pskRaw = "4ac51a255791c6ec52af3fd3f09cf6d9412f9305156d2d38f81798aec41eeb8f";
  };
  networking.wireless.networks."Laisvas Internetas_FC7A" = {
    priority = 4;
    pskRaw = "4d367689b1b912bc7a678673ff1944f8c1dc5b4188ce2346bf50572034be66eb";
    authProtocols = [
      "WPA-PSK"
      "WPA-EAP"
      "IEEE8021X"
      "WPA-PSK-SHA256"
    ];
  };
}
