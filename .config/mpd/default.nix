# https://wiki.nixos.org/wiki/MPD
# https://raw.githubusercontent.com/MusicPlayerDaemon/MPD/master/doc/mpdconf.example
# https://github.com/MusicPlayerDaemon/MPD
{
  pkgs,
  config,
  lib,
  xdgconf,
  ...
}:
let
  confDir = "${xdgconf}/mpd";
  playlistDir = "${confDir}/playlists";
in
rec {
  environment.systemPackages = [
    pkgs.mpd
    pkgs.mpc
  ];
  networking.firewall.allowedTCPPorts = [ 6600 ];
  services.mpd.enable = true;
  services.mpd.startWhenNeeded = true;
  services.mpd.user = "pipewire";
  services.mpd.group = "audio";
  # /run/mpd/mpd.conf
  services.mpd.settings.include_optional = "${confDir}/mpd.conf";
  # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
  systemd.services.mpd.environment.XDG_RUNTIME_DIR = "/run/user/${
    toString config.users.users."pipewire".uid
  }";
  systemd.tmpfiles.settings."10-mpd" = {
    "/var/lib/mpd/playlists/chill.m3u" = lib.mkIf true {
      "L+" = {
        user = services.mpd.user;
        group = services.mpd.group;
        mode = "0777";
        type = "L+";
        argument = "${playlistDir}/chill.m3u";
      };
    };
    "/var/lib/mpd/playlists/lt.m3u" = lib.mkIf true {
      "L+" = {
        user = services.mpd.user;
        group = services.mpd.group;
        mode = "0777";
        type = "L+";
        argument = "${playlistDir}/lt.m3u";
      };
    };
    "/var/lib/mpd/music/Music" = lib.mkIf true {
      "L+" = {
        user = services.mpd.user;
        group = services.mpd.group;
        mode = "0777";
        type = "L+";
        argument = "${config.hm.xdg.userDirs.music}";
      };
    };
  };
}
