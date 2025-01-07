# vim: nofoldenable
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.pulsemixer ];
  services.pulseaudio = {
    # https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#pulseaudiomodules
    package = pkgs.pulseaudioFull;
    enable = false;
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
}
