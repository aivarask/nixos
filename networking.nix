{ config, pkgs, lib, ... }:
{
  # networking.nat.enable = true;

  networking.hosts = {
    "127.0.0.1" = [
      "fix.deta.lt"

    ];
    "192.168.8.1" = [ "hw" "hw.lan" ];
    "192.168.8.120" = [ "as" "as.lan" ];
    "192.168.1.111" = [
      "pc"
      "pc.lan"
      "deta.lt"
      # "dev.deta.lt"
      "fix.deta.lt"
    ];
    # "88.118.15.237" = [
    "188.69.243.169" = [
      # Telia STATIC
      "wetty.deta.lt"
      "chat.deta.lt"
    ];
    "109.235.64.148" = [
      "kia.us.lt"
    ];
    "78.56.7.178" = [
      "gz"
      "gz.lan"
      "nasas.familyds.com"
      "nasas.verute.com" # ak lAikinas123*
      "nas"
      "nas.lan"
    ];
  };

  networking.nameservers = [
    # "127.0.0.1" # localhost
    # "192.168.8.1" # router
    "1.1.1.1" # Cloudflare
    # "8.8.8.8" # Google
    # "8.8.4.4" # Google2
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # SSL/https
    9000 # https://github.com/Unrud/remote-touchpad
    2022 # ssh-chat
    6600
    2234
    3000 # sveltekit dev
    4000
    6006 # storybook

    2000 # fix PROD
    2200 # fix DEV
    2220 # fix TEST
  ];

  # networking.firewall.allowedUDPPorts = [ ];

}
