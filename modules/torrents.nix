{ pkgs, config, ... }:
{
  environment.systemPackages = [
    pkgs.bitmagnet
    pkgs.magnetico
    pkgs.tremc
    pkgs.fragments
    pkgs.radarr
  ];
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openPeerPorts = true;
    settings = {
      # watch-dir = "${config.hm.xdg.userDirs.download}";
      watch-dir-enabled = true;
    };
  };
  # http://localhost:7878
  services.radarr = {
    enable = false;
    openFirewall = true;
    settings = {

    };
  };
}
