{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tremc
  ];
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    settings = {
      watch-dir = "/var/lib/transmission/watchdir";
      watch-dir-enabled = true;
    };
  };
}
