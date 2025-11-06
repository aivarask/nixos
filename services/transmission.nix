{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bitmagnet
    magnetico
    tremc
  ];
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openPeerPorts = true;
    settings = {
      watch-dir = "/var/lib/transmission/watchdir";
      watch-dir-enabled = true;
    };
  };
}
