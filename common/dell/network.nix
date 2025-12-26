{ ... }:
{
  networking.extraHosts = {
    "192.168.1.195" = [ "pcw" ];
    "192.168.1.190" = [ "pc" ];
  };
  networking.hostName = "dell";
  networking.hostId = "8425e349";
  systemd.network.networks."10-hw" = {
    name = "wlp59s0";
    matchConfig.Name = "wlp59s0";
    linkConfig.RequiredForOnline = "yes";
    networkConfig.DHCP = "ipv4";
    networkConfig.IPv6AcceptRA = true;
  };
}
