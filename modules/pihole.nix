# See <https://docs.pi-hole.net/ftldns/configfile/>
{ pkgs, ... }:
{
  services.pihole-ftl.enable = false;
  services.pihole-ftl.settings = {
    dns.upstreams = [
      "9.9.9.9"
      "1.1.1.1"
    ];
    dns.hosts = [ "192.168.1.188 hostname.domain" ];
  };
  services.pihole-ftl.lists = [
    {
      url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
      type = "block";
      enabled = true;
      description = "hagezi blocklist";
    }
  ];

  services.pihole-web = {
    enable = true;
    ports = [ "443s" ];
  };

}
