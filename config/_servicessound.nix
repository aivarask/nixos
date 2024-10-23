# vim:nofoldenable
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pulsemixer
    alsa-utils
    mpc_cli
  ];
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      # https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#pulseaudiomodules
      load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
      load-module module-combine-sink
    '';
    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = [
        "127.0.0.1"
        "0.0.0.0"
      ];
    };
  };
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    wireplumber.enable = true;
  };
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = ./playlist;
    # network.listenAddress = "any";
    startWhenNeeded = true;
    extraConfig = ''
      auto_update "yes"
      music_directory "/var/music"
      audio_output {
      	type "pulse"
      	# type "pipewire"
      	name "Pulseaudio"
      	# name "PipeWire Sound Server"
      	server "0.0.0.0"
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
