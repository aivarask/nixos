{ ... }:
{
  networking.hostName = "pc";
  networking.hostId = "007f0200";
  networking.enableIPv6 = false;

  networking.interfaces.eno1.wakeOnLan.enable = true;
  systemd.network.networks."10-eno1" = {
    name = "eno1";
    matchConfig.Name = "eno1";
    # linkConfig.RequiredForOnline = "yes"; # or routable
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
  };

  networking.wireless.enable = true;
  networking.wireless.driver = "wext"; # "TP-Link TL-WN881 ND"
  systemd.network.networks."20-wlp6s0" = {
    name = "wlp6s0";
    matchConfig.Name = "wlp6s0";
    linkConfig.RequiredForOnline = "yes";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
  };

}
