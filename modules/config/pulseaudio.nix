{ pkgs, ... }: {
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
}
