{ config, pkgs, lib, ... }:
{
  # networking.nat.enable = true;

  # https://nixos.wiki/wiki/Networking
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=networking.host
  networking.hosts = {
    "127.0.0.1" = [
      "live.fixasparts.com"
    ];
    "192.168.1.1" = [ "hw.lan" ];
    "192.168.1.111" = [ ];
    "188.69.243.169" = [
      # Telia STATIC
    ];
    "195.181.244.248" = [
      "q0nr.l.dedikuoti.lt"
      "fixas"
      "new.fixasparts.com"
    ];
  };
  networking.extraHosts = ''
    127.0.0.2 other-localhost
    10.0.0.1 server
  '';

  networking.nameservers = [
    # "127.0.0.1" # localhost
    # "192.168.1.1" # router
    "1.1.1.1" # Cloudflare
    # "8.8.8.8" # Google
    # "8.8.4.4" # Google2
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # SSL/https
    9000 # https://github.com/Unrud/remote-touchpad
    9100 # Printer testing
    2022 # ssh-chat
    6600
    2234
    3000 # sveltekit dev
    3306
    4000
    5173 # vite dev
    6006 # storybook

    2000 # fix PROD
    2200 # fix DEV
    2220 # fix TEST
  ];

  # networking.firewall.allowedUDPPorts = [ ];

}
