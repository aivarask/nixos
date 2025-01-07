# vim: nofoldenable
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.mpc-cli ];
  networking.firewall.allowedTCPPorts = [
    6600
    # 4712
  ];
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = ./.;
    network.listenAddress = "any";
    network.port = 6600;
    startWhenNeeded = true;
    extraConfig = ''
      auto_update "yes"
      music_directory "/var/music"
      audio_output {
      	type "pulse"
      	name "Pulseaudio"
      	server "127.0.0.1"
      }
      playlist_plugin {
      	name "m3u"
      	enabled "true"
      }
      # bind_to_address "0.0.0.0:6600"
      # bind_to_address "/var/lib/mpd/socket"
      bind_to_address "/run/mpd/socket"
    '';
  };

}
