{ pkgs, config, ... }:
{
  environment.systemPackages = [
    pkgs.bitmagnet
    pkgs.magnetico
    pkgs.tremc
    pkgs.fragments
  ];
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openPeerPorts = true;
    settings = {
      watch-dir = "${config.hm.xdg.userDirs.download}";
      watch-dir-enabled = true;
    };
  };
}
