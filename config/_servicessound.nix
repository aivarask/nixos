# vim: nofoldenable nowrap
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pulsemixer
    alsa-utils
    mpc_cli
  ];
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    wireplumber.enable = true;
  };
  hardware.pulseaudio = {
    # https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#pulseaudiomodules
    package = pkgs.pulseaudioFull;
    enable = true;
    systemWide = true;
    support32Bit = true;
    extraConfig = ''
      # https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-combine-sink
      # load-module module-combine-sink
      # https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-cli-protocol-unixtcp
      load-module module-cli-protocol-tcp listed=192.168.1.0/24
      # https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-native-protocol-unixtcp
      load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;192.168.1.0/24 auth-anonymous=1 auth-cookie-enabled=0

    '';
    # tcp = {
    #   enable = true;
    #   anonymousClients.allowedIpRanges = [
    #     "127.0.0.1"
    #     "0.0.0.0" # 192.168.0.0/24
    #   ];
    # };
  };
  networking.firewall.allowedTCPPorts = [
    4712
    6600
  ];
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = ./playlist;
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
