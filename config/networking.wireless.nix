{ lib, ... }:
{
  networking.wireless = {
    enable = lib.mkDefault true;
    userControlled = {
      enable = true;
      group = "wheel";
    };
    networks = {
      hw = {
        pskRaw = "4ac51a255791c6ec52af3fd3f09cf6d9412f9305156d2d38f81798aec41eeb8f";
      };
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
    };
  };
}
