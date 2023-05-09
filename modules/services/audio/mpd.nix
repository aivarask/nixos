{pkgs, ...}: {
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = ./.;
    network.listenAddress = "any";
    extraConfig = ''
      auto_update "yes"
      music_directory "/var/music"
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "0.0.0.0"
      }
      playlist_plugin {
        name "m3u"
        enabled "true"
      }
      bind_to_address "0.0.0.0:6600"
    '';
  };
}
