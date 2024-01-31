{ ... }: {
  networking. firewall.allowedTCPPorts = [ 9091 51413 ];
  services.transmission = {
    enable = false;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
}
