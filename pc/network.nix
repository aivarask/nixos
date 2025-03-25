{ lib, ... }:
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

  networking.nat = {
    enable = true;
    externalInterface = "br0"; # Your external interface
    # Note
    # - for every routed network created in Terrraform, you need to add a new internal interface here
    # - and a static route needs to be added to the LAN router for the new network
    internalInterfaces = [
      "virbr1"
      "virbr2"
      "virbr3"
      "virbr4"
      "virbr5"
      "virbr6"
      "virbr7"
    ]; # Your KVM bridge interface
  };
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ ]; # Empty since we're allowing all traffic
    allowedUDPPorts = [ ]; # Empty since we're allowing all traffic
    extraCommands = lib.mkBefore ''
      # Allow all incoming and outgoing traffic on all interfaces
      iptables -A INPUT -j ACCEPT
      iptables -A OUTPUT -j ACCEPT
      iptables -A FORWARD -j ACCEPT
    '';
  };
}
