{
  hm = { ... }: { };
  system =
    # https://wiki.nixos.org/wiki/MPD
    # https://raw.githubusercontent.com/MusicPlayerDaemon/MPD/master/doc/mpdconf.example
    { pkgs, config, ... }:
    rec {
      environment.systemPackages = [
        pkgs.mpd
        pkgs.mpc-cli
      ];
      networking.firewall.allowedTCPPorts = [ 6600 ];
      services.mpd.enable = true;
      services.mpd.user = "pipewire";
      services.mpd.group = "wheel";
      # services.mpd.network.listenAddress = "any";
      # services.mpd.network.port = 6600;
      services.mpd.startWhenNeeded = true;
      # /run/mpd/mpd.conf
      services.mpd.extraConfig = ''
        auto_update "yes"
        playlist_plugin {
        name "m3u"
        enabled "true"
        }
        audio_output {
        type "pipewire"
        name "PipeWire Output"
        }

      '';
      systemd.services.mpd.environment = {
        # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users."pipewire".uid}";
      };
      systemd.tmpfiles.settings."10-mpd" = {
        "/var/lib/mpd/playlists/" = {
          "L+" = {
            user = services.mpd.user;
            group = services.mpd.group;
            mode = "0755";
            type = "L+";
            argument = "/etc/nixos/audio/playlists";
          };
        };
        "/var/lib/mpd/music" = {
          # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
          "L+" = {
            user = services.mpd.user;
            group = services.mpd.group;
            mode = "0755";
            type = "L+";
            argument = "${config.hm.xdg.userDirs.music}";
          };
        };
      };
      # https://search.nixos.org/options?channel=unstable&show=systemd.tmpfiles.rules&from=0&size=50&sort=relevance&type=packages&query=systemd.tmpfiles

      system.userActivationScripts.linktoplaylist = {
        text = ''
          su="${pkgs.su}/bin/su"
                    				su aiva --shell ${pkgs.runtimeShell} --command "mkdir /home/aiva/foo"
                              # if [[ ! -h "/var/lib/mpd/playlists/audio" ]]; then
                              # notify-send 'create symlink'
                              # ln -s "/var/lib/mpd/playlists/audio" "/etc/nixos/audio/" 
                              # else
                              # unlink "/var/lib/mpd/playlists/audio"
                              # notify-send 'unlink'
                              # fi
        '';

      };
    };
}
