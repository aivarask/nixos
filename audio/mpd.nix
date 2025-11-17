{
  hm = { ... }: { };
  system =
    # https://wiki.nixos.org/wiki/MPD
    # https://raw.githubusercontent.com/MusicPlayerDaemon/MPD/master/doc/mpdconf.example
    {
      pkgs,
      config,
      lib,
      ...
    }:
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
      # services.mpd.network.listenAddress = "any";
      # services.mpd.network.port = 6600;
      # /run/mpd/mpd.conf
      services.mpd.extraConfig = ''
        bind_to_address    "/var/lib/mpd/socket"
        auto_update "yes"
        audio_output {
        type "pipewire"
        name "PipeWire Output"
        }
        playlist_plugin {
        name "m3u"
        enabled "true"
        }
        include_optional "/etc/nixos/audio/mpd.conf"

      '';
      systemd.services.mpd.environment = {
        # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users."pipewire".uid}";
      };
      systemd.tmpfiles.settings."10-mpd" = {
        "/var/lib/mpd/playlists/link" = lib.mkIf true {
          "L+" = {
            user = services.mpd.user;
            group = services.mpd.group;
            mode = "0777";
            type = "L+";
            argument = "/etc/nixos/audio/playlists";
          };
        };
        # "/var/lib/mpd/music" = lib.mkIf false {
        #   # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
        #   "L+" = {
        #     user = services.mpd.user;
        #     group = services.mpd.group;
        #     mode = "0777";
        #     type = "L+";
        #     argument = "${config.hm.xdg.userDirs.music}";
        #   };
        # };
      };
      # https://search.nixos.org/options?channel=unstable&show=systemd.tmpfiles.rules&from=0&size=50&sort=relevance&type=packages&query=systemd.tmpfiles

      # system.userActivationScripts.linktoplaylist = {
      #   text = ''
      #     su="${pkgs.su}/bin/su"
      #               				su aiva --shell ${pkgs.runtimeShell} --command "mkdir /home/aiva/foo"
      #                         # if [[ ! -h "/var/lib/mpd/playlists/audio" ]]; then
      #                         # notify-send 'create symlink'
      #                         # ln -s "/var/lib/mpd/playlists/audio" "/etc/nixos/audio/"
      #                         # else
      #                         # unlink "/var/lib/mpd/playlists/audio"
      #                         # notify-send 'unlink'
      #                         # fi
      #   '';
      #
      # };
    };
}
