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
      fileSystems."/root/Downloads/_transmission" = {
        depends = [
          "/var/lib/transmission/Downloads"
          "/root/Downloads"
        ];
        device = "/var/lib/transmission/Downloads";
        fsType = "none";
        options = [
          "bind"
          # "ro"
        ];
      };
      watch-dir-enabled = true;
      watch_dir_force_generic = true;
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
