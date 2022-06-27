# https://nixos.wiki/wiki/MPD
# https://mpd.fandom.com/wiki/PulseAudio
{ config, pkgs, ... }: {
  sound.enable = true;
  # sound.mediaKeys.enable = true;
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
    support32Bit = true;
    extraConfig =
      "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = [
        "127.0.0.1"
        # TODO: Stud IP subnets syntax
        # "192.168.8.0/24"
        "0.0.0.0"
      ];
    };
  };
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = ./.;
    network.listenAddress = "any";
    extraConfig = ''
      auto_update "yes"
      music_directory "/etc/nixos/music"
      audio_output { 
        type "pulse"
        name "Pulseaudio"
        server "0.0.0.0"
      }

      # audio_output {
      #   type		"httpd"
      #   name		"My HTTP Stream"
      #   encoder		"opus"		# optional
      #   port		"8000"
      #   #	quality		"5.0"			# do not define if bitrate is defined
      #   bitrate		"128000"			# do not define if quality is defined
      #   format		"48000:16:1"
      #   always_on       "yes"			# prevent MPD from disconnecting all listeners when playback is stopped.
      #   tags            "yes"			# httpd supports sending tags to listening streams.
      # }
    '';
  };
}
