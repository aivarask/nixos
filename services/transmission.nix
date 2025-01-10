{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tremc
  ];
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
}
