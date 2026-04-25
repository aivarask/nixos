# https://docs.pi-hole.net/ftldns/configfile/
{ pkgs, ... }:
{
  services.pihole-web.enable = true;
  services.pihole-web.ports = [ "443s" ];
  services.pihole-ftl.enable = true;
  services.pihole-ftl.settings.dns.upstreams = [
    # "192.168.0.142"
    # "192.168.0.1"
    "9.9.9.9"
    "1.1.1.1"
  ];
  services.pihole-ftl.settings.dns.hosts = [
    "192.168.1.188 hostname.domain"
    "9.9.9.9 linkomanija.net"
  ];
  services.pihole-ftl.lists = [
    {
      url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
      type = "block";
      enabled = true;
      description = "hagezi";
    }
    {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
      type = "block";
      enabled = true;
      description = "StevenBlack";
    }
  ];
}
